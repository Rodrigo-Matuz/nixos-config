# Optional NixOS setup from the dotfiles repository

[`../install.sh`](../install.sh) clones the complete dotfiles repository and uses
its separate `#install` profile. The `#nixos` output is the original `matuz`
workstation profile; **never install that profile on another machine**. This
installer supports x86_64 NixOS only. It offers a non-root VM preview, a fresh
UEFI installation, and an explicitly opt-in switch of an installed NixOS host.
It never repartitions, formats, or mounts disks during setup. In ISO and
installed modes it can optionally configure **existing formatted data volumes**
to mount on the installed system. It leaves an existing `/etc/nixos` tree in
place and refuses to overwrite `portable-config`.

## Publication status and bootstrap

The planned public Git URL is
`https://github.com/Rodrigo-Matuz/dotfiles.git`; it is **not public yet**.
`DEFAULT_REPO_URL` in `../install.sh` already points there. Before publication,
use `--repo /path/to/committed/dotfiles` to clone a local Git checkout; the
installer does not use uncommitted or untracked files in that source. When the
repository is public, users can download **only the bootstrap** and let it
clone the full repository:

```bash
curl -fsSLo install.sh https://raw.githubusercontent.com/Rodrigo-Matuz/dotfiles/main/install.sh
less install.sh
# Then run one of the mode commands below.
```

**This download is not yet functional.** The planned
`https://www.matuz.dev/nixos-installscript` URL currently serves a 404 page;
publishing to GitHub alone does not create that website route. To use the
website URL later, configure it to serve the raw `install.sh`, confirm that it
returns the actual script (not HTML), and review it before executing it with
sudo. Only run code from a source you trust; VM preview is not a security
sandbox for untrusted Nix expressions or build scripts. The VM launcher can
expose a writable host exchange directory and guest networking.

## Fresh NixOS installation

1. Boot an **x86_64 NixOS live installer in UEFI mode** with Internet access.
   Plan your partitions and filesystem, then partition/format manually. Mount
   target `/` at `/mnt` and its EFI system partition at `/mnt/boot`. Keep a
   backup of anything you intend to replace. Other layouts/bootloaders are
   not supported by this script.
2. Download and read `install.sh` as shown above. Then run:

   ```bash
   sudo bash install.sh --mode iso
   # Before publication, with a local Git checkout containing the installer:
   # sudo bash /path/to/dotfiles/install.sh --mode iso --repo /path/to/dotfiles
   ```

3. Type a **required** normal username (not `root`), hostname, time zone, and
   state version. Press Enter at the optional Home Manager/system module
   prompts to choose none; otherwise enter their displayed numbers separated
   by spaces or commas. You can then opt in to additional data partitions: the
   script displays each supported partition's device (for example `/dev/sdc1`),
   size, filesystem, label, UUID and existing mountpoint; answer yes/no for
   each, then enter a mount name such as `linux_hd` for `/mnt/linux_hd`. The
   chosen username controls the new NixOS account, `/home/NAME`, and Home
   Manager identity. The script generates hardware settings **from your mounted
   target**, dry-builds the selected profile, and requires the literal `YES`
   before running `nixos-install`.
4. Complete both password prompts (root and the chosen user). The script
   explicitly invokes `passwd` in the target even if the bootstrap was
   piped into Bash. Reboot only after both passwords are set. The persistent
   configuration is `/etc/nixos/portable-config` on the installed system.

For a custom mount root, pass `--root /absolute/path`; its `/boot` must be a
mounted EFI system partition. Nothing is installed if prerequisites or the
pre-install confirmation fail, but the script may leave generated files in
the mounted target only after confirmation. A dry-build cannot prove the
machine will boot or that optional graphical modules work on its hardware.

**Data-mount behavior:** This opt-in does not prepare a new disk: root and EFI
must already be mounted, and unformatted, encrypted/locked, swap, or unknown
filesystems are not offered. A partition already mounted outside the data
area (for example `/home`) is skipped, as is a filesystem UUID shared by
multiple devices. Existing `/mnt/NAME` targets must be empty or already mount
the same filesystem; symlinked mount parents are rejected. Supported data
filesystems are ext4, btrfs, xfs, NTFS (mounted with `ntfs3`), FAT (`vfat`)
and exFAT. The generated
`install/partitions.nix` uses filesystem UUIDs and `nofail` with a device
timeout so an absent data disk does not prevent boot. FAT, exFAT and NTFS use
UID/GID mount options and `umask=022`; for ext4/btrfs/xfs, a systemd oneshot
gives the chosen user ownership and write permission on the **mount root only**
after mounting. Existing files and subdirectories keep their original owners
and modes; this is not a recursive ownership takeover. NTFS volumes must be
cleanly shut down in Windows (Fast Startup/hibernation disabled) for reliable
read-write access. Review `/boot` free space and back up important data before
changing boot/system configuration. VM preview never imports host data mounts.

## Existing NixOS: try the configuration in a VM

This is the recommended path for a user who already has an installation and
wants to **try** the configuration. Run without `sudo`; `preview` is the
script's default mode:

```bash
bash install.sh --mode preview
# Before publication, from any directory:
# bash /path/to/dotfiles/install.sh --mode preview --repo /path/to/dotfiles
```

Provide your preferred VM username and select optional modules (or none).
After a `YES` prompt, the script builds `nixos-rebuild build-vm` with
VM-specific hardware settings; it prints the command to start the VM.
The VM console automatically logs in as the chosen user **in the VM only**;
no password is set on the host. Shut down the VM when finished.

Preview needs an x86_64 NixOS host, working Nix daemon, Git (or network to
fetch it), enough build disk space, QEMU/virtualisation support, and an
interactive terminal. It creates
`~/.local/share/dotfiles-preview/portable-config` (or
`$XDG_DATA_HOME/dotfiles-preview/portable-config`) and Nix store output, but
**does not import the host disk UUIDs, mount partitions, write `/etc/nixos`,
install NixOS, or switch your running generation**. The host remains on its
existing configuration. Move that preview directory aside manually to
create a different selection; the script refuses to overwrite it. A VM does
not validate real GPU/display/hardware integration; some optional desktop
modules may require adaptation or a suitable GUI session. This installer
is not for an existing non-NixOS Linux distribution.

## Existing NixOS: apply to the host (advanced)

**This changes the host; do not use it just to try the config.** The host must
already use UEFI + systemd-boot with the EFI system partition mounted at
`/boot`. Make a backup of `/etc/nixos`, user data, and your working boot
configuration. Review how this portable profile differs from the old one:
services, boot settings, users/groups, network and Home Manager files may
change. Record the **original `system.stateVersion`** from your current
NixOS configuration; do not replace it with the current release number.

```bash
sudo bash install.sh --mode installed
# Or, before publication:
# sudo bash /path/to/dotfiles/install.sh --mode installed --repo /path/to/dotfiles
```

The script copies this host's `/etc/nixos/hardware-configuration.nix` to a
new `/etc/nixos/portable-config` checkout. It can optionally generate UUID-based
data mounts through the same per-partition questions as ISO mode. It then
dry-builds, asks for `YES`, runs `nixos-rebuild switch`, and asks for the
selected user's password. This is still a **full profile switch**, not a way
to add mounts to your current workstation configuration. This mode requires
systemd-boot and is not supported on the GRUB workstation in this repository. It
does not overwrite the previous `/etc/nixos` files, but **switching can stop
services or disrupt access**; it has no automatic rollback. Some selected
Home Manager modules use `force = true` and may replace existing application
files during activation (for example, LibreWolf settings); back up those
application profiles as well. Recover from a prior NixOS boot generation if
necessary, or use `sudo nixos-rebuild switch --rollback` while the host is
still usable. To rebuild an edited portable selection later, run
`sudo nixos-rebuild switch --flake /etc/nixos/portable-config#install`.

## Selection and module extension

- `selection.nix` holds evaluation defaults. The installer writes a *local*
  selection in the cloned checkout. Keep generated host hardware and state
  version with that host, not as shared defaults for other users.
- `portable.nix` imports either target-generated hardware, the host's
  hardware in installed mode, or empty hardware in VM mode (where `build-vm`
  supplies virtual devices), plus `install/partitions.nix`. The latter is an
  empty module by default; the installer generates it **in the new clone**
  when data mounts are selected. It does not import or overwrite the
  workstation's root `partitions.nix`. A fresh account gets explicit UID 1000
  only when a data partition is selected; installed mode preserves the selected
  account's existing numeric UID. It includes a minimal NixOS base; every
  non-essential Home Manager and system module is opt-in.
- To add a normal Home Manager module, add `home/NAME/default.nix` and a
  README; the script discovers it automatically. A system module goes at
  `system/NAME/default.nix`. A module requiring another **flake input** also
  needs that input declared and locked in `flake.nix`, plus a conditional
  import/overlay in `portable.nix`. Evaluate/build `#install` after adding it.
- `noctalia` and `snappy-switcher` are hidden until their undeclared flake
  inputs are wired and locked. `nvim` and `nvchad` conflict, as do `caelestia`
  and `wallpaper`. Caelestia auto-selects Hyprland.
- The workstation's `#nixos` still uses the fixed `matuz` identity. Selecting
  a username in `#install` does not replace personal Git identity, bookmarks,
  branding, or hardware assumptions **inside individual optional modules**.
  Inspect modules before selecting them.

## Hardware and account cautions

- Hyprland Lua settings reference specific monitors and AMD graphics. No
  display manager or tty autologin is configured on the installed host;
  launch the graphical session manually after login. The VM-only variant
  enables console autologin for preview.
- `home/git` sets a personal Git identity. `home/nvtop` uses the AMD variant.
  `home/obs`/`home/vesktop` configure Hyprland autostarts; OBS assumes a
  particular display. `steam` opens game ports and starts its user service.
  `home/hermes` expects `/var/lib/hermes/env`; set appropriate permissions
  and credentials before enabling it. Never commit secrets.
- Review the whole repository for private values, host identifiers and
  credentials before publishing a public `dotfiles` repository. `flake.lock`,
  `install.sh`, `install/`, and all referenced modules must be included for the
  public bootstrap to work.
