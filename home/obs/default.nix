{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.extraLuaFiles = {
    "apps/obs" = {
      content = ./obs.lua;
      autoLoad = true;
    };
  };

  programs.obs-studio = {
    enable = true;

    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vaapi
      obs-vkcapture
    ];
  };

}
