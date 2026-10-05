{ config, pkgs, inputs, ... }:

{
  # ===========================================================================
  # Caelestia
  # ===========================================================================
  programs.caelestia = {
    enable = true;
    # Use the shell without its bundled CLI; the single CLI below is our fork.
    package = inputs.caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
      patches = (old.patches or []) ++ [ ./lock-notifications.patch ];
    });

    # -------------------------------------------------------------------------
    # Systemd
    # -------------------------------------------------------------------------
    systemd = {
      enable = true;
    };

    # -------------------------------------------------------------------------
    # Shell
    # -------------------------------------------------------------------------
    settings = {

      # -----------------------------------------------------------------------
      # General
      # -----------------------------------------------------------------------
      general.apps = {
        terminal = [ "kitty" ];
        audio = [ "pwvucontrol" ];
        playback = [ "mpv" ];
        explorer = [ "thunar" ];
      };

      general.idle = {
        lockBeforeSleep = true;
        inhibitWhenAudio = true;
      };

      # -----------------------------------------------------------------------
      # Appearance
      # -----------------------------------------------------------------------
      # Kitty uses background #050505 at 0.60 opacity. The Matuz scheme uses
      # the same base; keep the shell's separate card-layer opacity at 0.4.
      appearance.transparency = {
        enabled = true;
        base = 0.60;
        layers = 0.4;
      };

      border = {
        thickness = 0;
        rounding = 0;
        smoothing = 0;
      };

      # -----------------------------------------------------------------------
      # Background / Wallpaper
      # -----------------------------------------------------------------------
      background = {
        enabled = true;
        wallpaperEnabled = true;
        visualiser.enabled = true;
        desktopClock = false;
      };

      paths.wallpaperDir = "~/Pictures/Wallpapers";

      # -----------------------------------------------------------------------
      # Bar
      # -----------------------------------------------------------------------
      bar = {
        excludedScreens = [ "HDMI-A-1" ];

        tray.compact = true;

        scrollActions.brightness = false;

        popouts = {
          activeWindow = true;
          tray = true;
          statusIcons = true;
        };

        workspaces = {
          maxWindowIcons = 6;
          activeTrail = true;
        };

        statusIcons = [
          { id = "lockStatus"; enabled = true; }
          { id = "audio"; enabled = true; }
          { id = "microphone"; enabled = true; }
          { id = "kbLayout"; enabled = true; }
          { id = "network"; enabled = true; }
          { id = "bluetooth"; enabled = false; }
          { id = "battery"; enabled = false; }
        ];
      };

      # -----------------------------------------------------------------------
      # Dashboard
      # -----------------------------------------------------------------------
      dashboard = {
        enabled = true;
        showOnHover = true;
        showMedia = true;
        showPerformance = true;
        showWeather = true;

        performance = {
          showBattery = false;
          showGpu = true;
          showCpu = true;
          showMemory = true;
          showStorage = true;
          showNetwork = true;
        };
      };

      # -----------------------------------------------------------------------
      # Lock Screen
      # -----------------------------------------------------------------------
      lock = {
        enabled = true;
        useWallpaper = true;
        recolourLogo = true;
      };

      # -----------------------------------------------------------------------
      # Notifications
      # -----------------------------------------------------------------------
      notifs.actionOnClick = true;

      # -----------------------------------------------------------------------
      # OSD
      # -----------------------------------------------------------------------
      osd.enabled = true;
      osd.enableBrightness = false;

      # -----------------------------------------------------------------------
      # Session / Power
      # -----------------------------------------------------------------------
      session.icons.hibernate = "lock";
      session.commands.hibernate = ["loginctl" "lock-session"];

      # -----------------------------------------------------------------------
      # Sidebar
      # -----------------------------------------------------------------------
      sidebar = {
        enabled = true;
        showOnHover = true;
      };

      # -----------------------------------------------------------------------
      # Utilities
      # -----------------------------------------------------------------------
      utilities.toasts.nowPlaying = false;

      utilities.quickToggles = [
        { id = "wifi"; enabled = true; }
        { id = "bluetooth"; enabled = false; }
        { id = "mic"; enabled = true; }
        { id = "settings"; enabled = true; }
        { id = "gameMode"; enabled = true; }
        { id = "dnd"; enabled = true; }
        { id = "vpn"; enabled = true; }
      ];
    };

    # -------------------------------------------------------------------------
    # Caelestia CLI
    # -------------------------------------------------------------------------
    cli = {
      enable = true;
      package = inputs.caelestia-cli.packages.${pkgs.stdenv.hostPlatform.system}.default;

      settings = {
        theme.enableGtk = true;
      };
    };
  };


  # ===========================================================================
  # Per-Monitor Configuration
  # ===========================================================================

  # ---------------------------------------------------------------------------
  # DP-1
  # ---------------------------------------------------------------------------
  # home.file.".config/caelestia/monitors/DP-1/shell.json".text =
  #   builtins.toJSON {
  #     bar = {
  #       position = "left";
  #     };
  #   };


  # ---------------------------------------------------------------------------
  # DP-2
  # ---------------------------------------------------------------------------
  # home.file.".config/caelestia/monitors/DP-2/shell.json".text =
  #   builtins.toJSON {
  #     bar = {
  #       position = "right";
  #     };
  #   };

  # ---------------------------------------------------------------------------
  # HDMI-A-1
  # ---------------------------------------------------------------------------
  home.file.".config/caelestia/monitors/HDMI-A-1/shell.json".text =
    builtins.toJSON {
      lock = {
        enabled = false;
      };
    };
}
