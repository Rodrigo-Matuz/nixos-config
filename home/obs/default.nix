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

    (pkgs.writeShellApplication {
      name = "obs-control";
      runtimeInputs = [ pkgs.obs-cmd ];
      text = builtins.readFile ./obs-control.sh;
    })
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
