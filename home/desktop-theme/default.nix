{ pkgs, ... }:

let
  fantasyIconTheme = pkgs.stdenvNoCC.mkDerivation {
    pname = "fantasy-icon-theme";
    version = "2021-02-02";

    src = pkgs.fetchFromGitHub {
      owner = "yeyushengfan258";
      repo = "Fantasy-icon-theme";
      rev = "993280f3117bbe1eebcfc5dfa07f33a36845edc7";
      hash = "sha256-yFJUbg+HTwInaNi5Od9ueJqfiMQrGMd4zX/dA9dy4eQ=";
    };

    nativeBuildInputs = [ pkgs.gtk3 ];

    dontCheckForBrokenSymlinks = true;

    installPhase = ''
      runHook preInstall
      mkdir -p "$out/share/icons"
      name=Fantasy theme=-blue bash ./install.sh --dest "$out/share/icons"
      runHook postInstall
    '';
  };
  matuzGtkTheme = pkgs.runCommand "matuz-dark-gtk-theme" { } ''
    mkdir -p "$out/share/themes/MatuzDark/gtk-3.0" "$out/share/themes/MatuzDark/gtk-4.0"
    cp ${./gtk-3.0/gtk.css} "$out/share/themes/MatuzDark/gtk-3.0/gtk.css"
    cp ${./gtk-4.0/gtk.css} "$out/share/themes/MatuzDark/gtk-4.0/gtk.css"
  '';
in
{
  # Shared palette with Dolphin; GTK 3 inherits Adwaita widget behavior.
  # GTK 4/libadwaita supports only partial CSS theming.
  gtk = {
    enable = true;
    colorScheme = "dark";
    # Adwaita's high-specificity header rules survive the theme CSS.
    # User CSS has a higher GTK style-provider priority than theme CSS.
    gtk3.extraCss = builtins.readFile ./gtk-3.0/file-chooser.css;

    theme = {
      package = matuzGtkTheme;
      name = "MatuzDark";
    };

    gtk4.theme = {
      package = matuzGtkTheme;
      name = "MatuzDark";
    };

    iconTheme = {
      package = fantasyIconTheme;
      name = "Fantasy-blue-dark";
    };
  };

  # Persist the GNOME/GTK preference for applications that read GSettings
  # instead of GTK settings.ini directly.
  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    gtk-theme = "MatuzDark";
    icon-theme = "Fantasy-blue-dark";
  };

  # KDE's Qt platform integration reads the MatuzDark kdeglobals scheme and
  # the Fantasy-dark icon theme selected by the Dolphin module.
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "breeze";
  };
}
