{ pkgs, ... }:

{
  home.packages = with pkgs; [
    satty
    grim
    grimblast
    slurp
    wl-clipboard
  ];
}
