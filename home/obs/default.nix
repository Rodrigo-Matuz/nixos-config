{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.extraLuaFiles = {
    "apps/obs" = {
      content = ./obs.lua;
      autoLoad = true;
    };
  };

  home.packages = [
    pkgs.obs-cmd

    (pkgs.writeShellScriptBin "obs-control"
      (builtins.readFile ./obs-control.sh))
  ];

  programs.obs-studio = {
    enable = true;

    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vaapi
      obs-vkcapture
    ];
  };
}
