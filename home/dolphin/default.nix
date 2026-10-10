{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.kdePackages.dolphin
    pkgs.kdePackages.ark
    pkgs.kdePackages.ffmpegthumbs
    pkgs.kdePackages.kdegraphics-thumbnailers
    pkgs.kdePackages.kimageformats
    pkgs.kdePackages.qtimageformats
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications."inode/directory" = [ "org.kde.dolphin.desktop" ];
    associations.added."inode/directory" = [ "org.kde.dolphin.desktop" ];
  };
  xdg.configFile."mimeapps.list".force = true;

  xdg.configFile."kdeglobals".text = ''
    [General]
    AccentColor=30,101,255
    ColorScheme=MatuzDark

    [Icons]
    Theme=Fantasy-blue-dark
  '';

  xdg.dataFile."color-schemes/MatuzDark.colors".source =
    ./MatuzDark.colors;
}
