{ config, pkgs, inputs, ... }:
{
  programs.wallpaper-picker-ui = {
    enable = true;

    # The command the app runs when you apply a wallpaper.
    # $VP is replaced with the selected file path.
    command = "${pkgs.mpvpaper}/bin/mpvpaper -o \"loop no-audio\" \"*\" \"$VP\"";

    # Folder to scan for wallpapers.
    wallpapersPath = "${config.home.homeDirectory}/Wallpapers";

    # App behaviour preferences.
    debugMode = false;
    newWallpapers = true;
    darkMode = true;

    # UI language: "eng", "pt-br", "de", "fr", "es".
    language = "eng";
  };
}
