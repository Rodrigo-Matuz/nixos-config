{ pkgs, ... }:

let
  rem-cursors = pkgs.stdenvNoCC.mkDerivation {
    pname = "rem-by-blz-cursors";
    version = "2025-07";

    # Generated with ani2xcursor, then converted to hyprcursor with
    # hyprcursor-util. The combined theme contains both XCursor and
    # hyprcursor data so GTK/XWayland and native Wayland clients use the
    # same animated cursor theme.
    src = ./rem_by_blz;

    installPhase = ''
      mkdir -p $out/share/icons/rem_by_blz
      cp -R ./* $out/share/icons/rem_by_blz/
    '';
  };
in
{
  home.pointerCursor = {
    enable = true;
    package = rem-cursors;
    name = "rem_by_blz";
    size = 12;

    gtk.enable = true;
    x11.enable = true;
  };
}
