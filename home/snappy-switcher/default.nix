{ inputs, pkgs, ... }:

{
  home.packages = [
    inputs.snappy-switcher.packages.${pkgs.system}.default
  ];
}
