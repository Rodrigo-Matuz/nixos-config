{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.wallpaper-picker-ui.homeManagerModules.default ];

  programs.wallpaper-picker-ui = {
    enable = true;

    # The command the app runs when you apply a wallpaper.
    # $VP is replaced with the selected file path.
    command = "caelestia set wallpaper \"$VP\"";

    # Folder to scan for wallpapers.
    wallpapersPath = "${config.home.homeDirectory}/Wallpapers";

    # App behaviour preferences.
    debugMode = true;
    newWallpapers = true;
    darkMode = true;

    # UI language: "eng", "pt-br", "de", "fr", "es".
    language = "eng";
  };
}
