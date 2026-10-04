{ pkgs, ... }:

let
  nier-cursors = pkgs.stdenvNoCC.mkDerivation {
    pname = "nier-cursors";
    version = "2020-08-25";

    src = ./NieR_Cursors_2020-08-25.tar.xz;

    installPhase = ''
      mkdir -p $out/share/icons/nier_cursors
      cp -r ./* $out/share/icons/nier_cursors/
    '';
  };
in
{
  home.pointerCursor = {
    enable = true;
    package = nier-cursors;
    name = "nier_cursors";
    size = 24;

    gtk.enable = true;
    x11.enable = true;
  };
}
