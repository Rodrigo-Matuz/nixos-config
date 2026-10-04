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
}
