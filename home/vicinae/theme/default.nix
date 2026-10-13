# Matuz Palette — a dark Vicinae theme
#
# Palette (from matuz.dev portfolio + wallpaper-picker-ui):
#   BG       #050505
#   Red      #fc1a70
#   Purple   #702ef3
#   Blue     #1e65ff
#   Orange   #ff4d00
#   Yellow   #ffff87
#   Green    #a4e400
#
# This file returns the theme definition as an attribute set. It is imported
# by /etc/nixos/home/vicinae/default.nix via `programs.vicinae.themes`, which
# builds it into ~/.local/share/vicinae/themes/matuz-palette.toml.

{
  # Attribute name = theme file name (without the .toml extension).
  matuz-palette = {
    meta = {
      version = 1;
      name = "Matuz Palette";
      description = "Dark theme matching the matuz.dev / wallpaper-picker-ui palette";
      variant = "dark";
      # Fall back to the built-in Vicinae dark palette for any colour we don't set.
      inherits = "vicinae-dark";
    };

    colors = {
      # --- Core surface -------------------------------------------------
      core = {
        accent = "#1e65ff";
        accent_foreground = "#ffffff";
        background = "#050505";
        foreground = "#fffff0";
        secondary_background = "#151515";
        border = "#3e364f";
      };

      # --- Accent palette (the colours you specified) -------------------
      accents = {
        red = "#fc1a70";
        purple = "#702ef3";
        blue = "#1e65ff";
        orange = "#ff4d00";
        yellow = "#ffff87";
        green = "#a4e400";
      };

      # --- Text ----------------------------------------------------------
      text = {
        default = "#fffff0";
        muted = "#d8d0e8";
        danger = "#ff4d00";
        success = "#fc1a70";
        placeholder = { name = "#d8d0e8"; opacity = 0.6; };
      };

      "text.selection" = {
        background = "#1e65ff";
        foreground = "#ffffff";
      };

      "text.links" = {
        default = "#1e65ff";
        visited = "#fc1a70";
      };

      # --- Input fields -------------------------------------------------
      input = {
        border = "#62557d";
        border_focus = "#1e65ff";
        border_error = "#ff4d00";
      };

      # --- Buttons ------------------------------------------------------
      "button.primary" = {
        background = "#1f1f1f";
        foreground = "#fffff0";
      };

      "button.primary.hover" = {
        background = "#292929";
      };

      "button.primary.focus" = {
        outline = "#1e65ff";
      };

      # --- Lists ---------------------------------------------------------
      "list.item.hover" = {
        background = { name = "#00226b"; opacity = 0.25; };
        foreground = "#fffff0";
      };

      "list.item.selection" = {
        background = { name = "#00226b"; opacity = 0.50; };
        foreground = "#ccdcff";
        secondary_background = "#00226b";
        secondary_foreground = "#ccdcff";
      };

      # --- Grid items ----------------------------------------------------
      "grid.item" = {
        background = "#151515";
      };

      "grid.item.hover" = {
        outline = { name = "#702ef3"; opacity = 0.8; };
      };

      "grid.item.selection" = {
        outline = "#1e65ff";
      };

      # --- Scrollbars ----------------------------------------------------
      scrollbars = {
        background = { name = "#1e65ff"; opacity = 0.2; };
      };

      # --- Loading -------------------------------------------------------
      loading = {
        bar = "#1e65ff";
        spinner = "#1e65ff";
      };
    };
  };
}
