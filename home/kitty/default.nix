{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    # -------------------------------------------------------------------------
    # Font
    # -------------------------------------------------------------------------
    font = {
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
      size = 10;
    };

    # -------------------------------------------------------------------------
    # General Settings
    # -------------------------------------------------------------------------
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      background_opacity = 0.6;
    };

    # -------------------------------------------------------------------------
    # Shell Integration
    # -------------------------------------------------------------------------
    shellIntegration.enableZshIntegration = true;

    # -------------------------------------------------------------------------
    # Colors
    # -------------------------------------------------------------------------
    extraConfig = ''
      background #050505
      foreground #fcfcfc
      cursor #f6f6ec

      selection_background #343434
      selection_foreground #191919

      color0  #202020
      color8  #505050

      color1  #FC1A70
      color9  #FC1A70

      color2  #A4E400
      color10 #A4E400

      color3  #FFFF87
      color11 #FF4D00

      color4  #702EF3
      color12 #702EF3

      color5  #FC1A70
      color13 #FC1A70

      color6  #1E65FF
      color14 #57d1ea

      color7  #fcfcfc
      color15 #fcfcfc

      color16 #FF4D00
    '';
  };
}