{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;

    systemd.enable = true;

    settings = {
      theme = {
        mode = "dark";
        source = "custom";
        custom_palette = "Matuz";
      };

      wallpaper = {
        enabled = true;
      };

      bar = {
        default = {
          position = "top";

          monitor = {
            "DP-1" = {
              match = "DP-1";
              position = "left";
            };

            "DP-2" = {
              match = "DP-2";
              position = "right";
            };

            "HDMI-A-1" = {
              match = "HDMI-A-1";
              enabled = false;
            };
          };
        };
      };
    };
  };

  home.file.".config/noctalia/palettes/Matuz.json".source =
    ./palettes/Matuz.json;
}
