{ pkgs, ... }:

{
  programs.rtorrent = {
    enable = true;
    package = pkgs.rtorrent;
  };
}
