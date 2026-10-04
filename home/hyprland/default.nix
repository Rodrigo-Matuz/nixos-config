{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    extraLuaFiles = {
      programs = ./programs.lua;
      envs = ./envs.lua;
      settings = ./general.lua;
      monitors = ./monitors.lua;
      workspaces = ./workspaces.lua;
      keybinds = ./keybinds.lua;
      windowrules = ./windowrules.lua;
      layerrules = ./layerrules.lua;
      misc = ./misc.lua;
    };
  };
}
