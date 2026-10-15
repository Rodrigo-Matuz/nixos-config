{ config, pkgs, ... }:

{
  # OBS UI theme: a Yami variant using the matuz.dev indigo/near-black
  # background with the site's saturated accent palette.
  xdg.configFile."obs-studio/themes/Matuz.ovt".source = ./Matuz.ovt;

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