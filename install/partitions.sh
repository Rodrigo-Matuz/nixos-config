#!/usr/bin/env bash
# shellcheck disable=SC2034 # partition_owner_uid is read by the sourcing install.sh
# Sourced by install.sh after cloning the portable profile. Never partitions,
# formats, mounts, or changes ownership on the running machine.

partition_yes_no() {
  local response
  ask "$1 (yes/no)" "$2"
  response=${REPLY,,}
  case $response in
    yes|y) return 0 ;;
    no|n) return 1 ;;
    *) fail 'Answer yes or no' ;;
  esac
}

configure_partitions() {
  local install_mode=$1 install_root=$2 checkout=$3 owner=$4
  local device kind filesystem uuid label size current_mount major_minor
  local root_major boot_major mount_name host_mount target_mount part_type
  local choices uuid_devices candidate value mounts mounted_path other_device other_uuid matches unsafe_mount
  local -a found=() selected_names=() selected_uuids=()
  partition_owner_uid=null

  # The VM has its own disks; it must never import host partition identifiers.
  [[ $install_mode != preview ]] || return 0
  if ! partition_yes_no 'Configure existing data partitions for automatic mounting?' no; then
    return 0
  fi

  require lsblk
  require blkid
  require findmnt
  if [[ $install_mode == iso ]]; then
    # A fresh install uses a fixed, explicit UID for the newly created account.
    partition_owner_uid=1000
    root_major=$(findmnt -rn -o MAJ:MIN --target "$install_root")
    boot_major=$(findmnt -rn -o MAJ:MIN --target "$install_root/boot")
  else
    id "$owner" >/dev/null 2>&1 || fail "Partition owner must already exist on this host: $owner"
    partition_owner_uid=$(id -u "$owner")
    root_major=$(findmnt -rn -o MAJ:MIN --target /)
    boot_major=$(findmnt -rn -o MAJ:MIN --target /boot)
  fi
  [[ -n $root_major && -n $boot_major ]] || fail 'Cannot identify root and EFI mounts'
  choices=$(lsblk -rnp -o PATH,TYPE --exclude 7,11) || fail 'Could not enumerate block devices'
  uuid_devices=$(lsblk -rnp -o PATH,UUID) || fail 'Could not check filesystem UUID uniqueness'
  printf '\nOnly existing, formatted data partitions are offered; root and EFI are excluded.\n'
  while read -r device kind; do
    [[ $kind == part ]] || continue
    major_minor=$(lsblk -dnro MAJ:MIN -- "$device") || fail "Cannot inspect $device"
    [[ $major_minor != "$root_major" && $major_minor != "$boot_major" ]] || continue
    # Do not offer other EFI system partitions as writable data volumes.
    part_type=$(lsblk -dnro PARTTYPE -- "$device" || true)
    case ${part_type,,} in
      c12a7328-f81f-11d2-ba4b-00a0c93ec93b|0xef|ef) continue ;;
    esac
    filesystem=$(blkid -s TYPE -o value -- "$device" 2>/dev/null || true)
    case $filesystem in
      ext4|btrfs|xfs|ntfs|ntfs3|vfat|exfat) ;;
      *) continue ;; # Swap, LUKS, unknown/unsupported, and unformatted devices.
    esac
    uuid=$(blkid -s UUID -o value -- "$device" 2>/dev/null || true)
    [[ $uuid =~ ^[A-Za-z0-9-]+$ ]] || { printf 'Skipping %s: missing/invalid filesystem UUID.\n' "$device" >&2; continue; }
    matches=0
    while read -r other_device other_uuid; do
      [[ $other_uuid != "$uuid" ]] || matches=$((matches+1))
    done <<< "$uuid_devices"
    if [[ $matches != 1 ]]; then
      printf 'Skipping %s: UUID %s appears on %s devices; /dev/disk/by-uuid would be ambiguous.\n' "$device" "$uuid" "$matches" >&2
      continue
    fi
    label=$(blkid -s LABEL -o value -- "$device" 2>/dev/null || true)
    size=$(lsblk -dnro SIZE -- "$device") || fail "Cannot read size of $device"
    mounts=$(lsblk -dnro MOUNTPOINTS -- "$device") || fail "Cannot inspect mounts for $device"
    current_mount=$(lsblk -dnro MOUNTPOINT -- "$device" || true)
    printf '\nPartition: %s  size=%s  filesystem=%s  label=%q  UUID=%s  mounted=%q\n' \
      "$device" "$size" "$filesystem" "${label:-<none>}" "$uuid" "${current_mount:-<unmounted>}"
    unsafe_mount=false
    while IFS= read -r mounted_path; do
      [[ -n $mounted_path ]] || continue
      if [[ $install_mode == iso ]]; then
        [[ $mounted_path == "${install_root%/}/mnt/"* ]] || unsafe_mount=true
      else
        [[ $mounted_path == /mnt/* ]] || unsafe_mount=true
      fi
    done <<< "$mounts"
    if [[ $unsafe_mount == true ]]; then
      printf 'Skipping %s: already mounted outside the data-mount directory (e.g. /home or /boot).\n' "$device" >&2
      continue
    fi
    if [[ -n $mounts ]]; then
      printf 'Already mounted at %s; adding another mount may expose the same filesystem twice.\n' "$current_mount"
    fi
    if [[ $filesystem == ext4 || $filesystem == btrfs || $filesystem == xfs ]]; then
      printf 'Ownership note: only the filesystem root directory will become writable by %s; existing files keep their permissions.\n' "$owner"
    fi
    if ! partition_yes_no "Mount $device in the installed system?" no; then
      continue
    fi
    ask 'Name under /mnt (e.g. linux_hd -> /mnt/linux_hd)' ''
    mount_name=$REPLY
    [[ $mount_name =~ ^[a-z][a-z0-9_-]*$ ]] || fail 'Mount name must start with a lowercase letter and contain only lowercase letters, digits, _ or -'
    for value in "${selected_names[@]:-}"; do
      [[ $value != "$mount_name" ]] || fail "Duplicate mount name: $mount_name"
    done
    selected_names+=("$mount_name")
    for value in "${selected_uuids[@]:-}"; do
      [[ $value != "$uuid" ]] || fail "Filesystem UUID selected twice: $uuid"
    done
    selected_uuids+=("$uuid")
    host_mount="/mnt/$mount_name"
    target_mount=$host_mount
    [[ $install_mode != iso ]] || target_mount="${install_root%/}$host_mount"
    [[ ! -L ${target_mount%/*} ]] || fail "Mount parent directory is a symlink: ${target_mount%/*}"
    [[ ! -L $target_mount ]] || fail "Mount target is a symlink: $target_mount"
    [[ ! -e $target_mount || -d $target_mount ]] || fail "Mount target is not a directory: $target_mount"
    if [[ -d $target_mount ]]; then
      if mountpoint -q -- "$target_mount"; then
        local existing_major
        existing_major=$(findmnt -rn -o MAJ:MIN --mountpoint "$target_mount") || fail "Cannot inspect mounted $target_mount"
        [[ $existing_major == "$major_minor" ]] || fail "Different filesystem is already mounted at $target_mount"
      elif (shopt -s nullglob dotglob; local -a contents=("$target_mount"/*); ((${#contents[@]}))); then
        fail "Mount target contains files that would be hidden: $target_mount"
      fi
    fi
    # Only the mount name and validated UUID are written; labels are display-only.
    found+=("$mount_name|$uuid|$filesystem")
  done <<< "$choices"

  if ((${#found[@]} == 0)); then
    partition_owner_uid=null
    printf 'No data partitions selected.\n'
    return 0
  fi

  printf '\nConfigured mounts (in the new portable profile):\n'
  for candidate in "${found[@]}"; do
    IFS='|' read -r mount_name uuid filesystem <<< "$candidate"
    printf '  /mnt/%s <- /dev/disk/by-uuid/%s (%s)\n' "$mount_name" "$uuid" "$filesystem"
  done
  printf 'Nothing has been formatted or mounted by this script.\n'
  local output="$checkout/install/partitions.nix"
  {
    printf '{ config, pkgs, ... }:\nlet\n  ownerUid = (import ./selection.nix).partitionOwnerUid;\n  ownerGid = config.users.groups.users.gid;\nin\n{\n'
    for candidate in "${found[@]}"; do
      IFS='|' read -r mount_name uuid filesystem <<< "$candidate"
      [[ $filesystem != ntfs ]] || filesystem=ntfs3
      printf '  fileSystems."/mnt/%s" = {\n    device = "/dev/disk/by-uuid/%s";\n    fsType = "%s";\n' "$mount_name" "$uuid" "$filesystem"
      if [[ $filesystem == ntfs3 || $filesystem == vfat || $filesystem == exfat ]]; then
        printf '    options = [ "nofail" "x-systemd.device-timeout=10s" "uid=${toString ownerUid}" "gid=${toString ownerGid}" "umask=022" ];\n  };\n'
      else
        printf '    options = [ "nofail" "x-systemd.device-timeout=10s" ];\n  };\n'
        printf '  # POSIX ownership cannot be set using ext4/btrfs/xfs mount options.\n'
        printf '  # Adjust ONLY the filesystem root; existing contents keep their ownership.\n'
        printf '  systemd.services."partition-owner-%s" = {\n' "$mount_name"
        printf '    wantedBy = [ "multi-user.target" ];\n    unitConfig.RequiresMountsFor = [ "/mnt/%s" ];\n    unitConfig.ConditionPathIsMountPoint = "/mnt/%s";\n' "$mount_name" "$mount_name"
        printf '    serviceConfig = {\n      Type = "oneshot";\n      ExecStart = "${pkgs.coreutils}/bin/chown ${toString ownerUid}:${toString ownerGid} /mnt/%s";\n' "$mount_name"
        printf '      ExecStartPost = "${pkgs.coreutils}/bin/chmod u+rwx /mnt/%s";\n    };\n  };\n' "$mount_name"
      fi
    done
    printf '}\n'
  } > "$output"
  printf 'Generated %s; native Linux mounts grant access to the mount root only, not existing files.\n' "$output"
}
