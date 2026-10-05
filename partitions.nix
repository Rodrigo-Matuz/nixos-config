{ config, lib, pkgs, ... }:

{
  fileSystems."/mnt/workspace_linux" = {
    device = "/dev/disk/by-uuid/FC44C33B44C2F802";
    fsType = "ntfs3";
    options = [
      "uid=1000"
      "gid=100"
      "umask=022"
      "rw"
    ];
  };

  fileSystems."/mnt/playground_steam" = {
    device = "/dev/disk/by-uuid/48FA5502FA54EDA6";
    fsType = "ntfs3";
    options = [
      "uid=1000"
      "gid=100"
      "umask=022"
      "rw"
    ];
  };

  fileSystems."/mnt/storage_hd" = {
    device = "/dev/disk/by-uuid/107AE5287AE50AF4";
    fsType = "ntfs3";
    options = [
      "uid=1000"
      "gid=100"
      "umask=022"
      "rw"
    ];
  };

  fileSystems."/mnt/modplace_ssd" = {
    device = "/dev/disk/by-uuid/F482388E82385778";
    fsType = "ntfs3";
    options = [
      "uid=1000"
      "gid=100"
      "umask=022"
      "rw"
    ];
  };

  fileSystems."/mnt/nvme_windows" = {
    device = "/dev/disk/by-uuid/BECCEE0ECCEDC0AF";
    fsType = "ntfs3";
    options = [
      "uid=1000"
      "gid=100"
      "umask=022"
      "rw"
    ];
  };

  # The NTFS metadata for this directory can preserve a read-only mode (555)
  # even though the volume itself is mounted read-write. Keep OBS's recording
  # destination writable after every boot/remount.
  systemd.services.storage-hd-obs-permissions = {
    description = "Make the OBS recording directory writable";
    wantedBy = [ "multi-user.target" ];
    after = [ "mnt-storage_hd.mount" ];
    requires = [ "mnt-storage_hd.mount" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      ${pkgs.coreutils}/bin/chmod 0755 "/mnt/storage_hd/OBS Videos"
    '';
  };
}
