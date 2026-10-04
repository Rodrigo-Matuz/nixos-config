{ pkgs, ... }:

{
  home.packages = [
    pkgs.nvtopPackages.amd
  ];
}
