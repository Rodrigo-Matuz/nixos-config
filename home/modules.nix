{ lib, ... }:

let
  entries = builtins.readDir ./.;
  moduleDirectories = lib.filterAttrs (name: type:
    type == "directory"
    && name != "optional"
    && !(lib.hasPrefix "_" name)
  ) entries;
in
{
  # Every top-level home module is part of the workstation profile. Optional
  # modules live under ./optional and are selected explicitly by the installer.
  # Adding or removing a directory therefore changes one source of truth: the
  # module directory itself, not both this profile and flake.nix.
  imports = lib.mapAttrsToList (name: _: ./. + "/${name}") moduleDirectories;
}
