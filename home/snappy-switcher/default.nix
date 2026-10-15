{ inputs, pkgs, ... }:

let
  snappy = inputs.snappy-switcher.packages.${pkgs.system}.default;
in
{
  home.packages = [ snappy ];

  # Keep this as a user-owned configuration so the switcher can be customized
  # without rebuilding the package or copying files into /usr/share.
  home.file.".config/snappy-switcher/config.ini".text = ''
    [general]
    mode = context
    follow_monitor = true
    show_workspace_badge = true
    sticky_mode = false
    ignore_pinned = false
    ignore_special = true

    [theme]
    name = matuz.ini
    border_width = 1
    card_border_width = 2
    corner_radius = 15

    [layout]
    card_width = 145
    card_height = 135
    card_gap = 10
    padding = 10
    max_cols = 5
    icon_size = 57
    icon_radius = 15
    error_font_size = 13

    [icons]
    theme = Adwaita
    fallback = hicolor
    show_letter_fallback = true

    [font]
    family = Sans
    weight = Bold
    title_size = 10
    icon_letter_size = 24
  '';

  home.file.".config/snappy-switcher/themes/matuz.ini".text = ''
    # Matuz palette shared with the Caelestia shell.
    # #05050599 is #050505 at 0.60 alpha.
    [colors]
    background = #05050599
    card_bg = #050505cc
    card_selected = #1E65FF66
    border_color = #702EF3ff
    text_color = #ffffffff
    subtext_color = #FFFF87ff
    bundle_bg = #FF4D0033
    badge_bg = #A4E400ff
    badge_text_color = #050505ff
    badge_bg_selected = #FC1A70ff
    badge_text_color_selected = #ffffffff
  '';

  systemd.user.services.snappy-switcher = {
    Unit = {
      Description = "Snappy Switcher - Alt+Tab window switcher for Hyprland";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${snappy}/bin/snappy-switcher --daemon";
      ExecStop = "${snappy}/bin/snappy-switcher quit";
      Restart = "on-failure";
      RestartSec = 3;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
