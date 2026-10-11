{ config, lib, ... }:

{
  options.matuz.hyprland.includeMonitorLayout = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Import the workstation monitor and workspace layout";
  };

  config.wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    extraLuaFiles = {
      programs = ./programs.lua;
      envs = ./envs.lua;
      settings = ./general.lua;
      keybinds = ./keybinds.lua;
      windowrules = ./windowrules.lua;
      layerrules = ./layerrules.lua;
      misc = ./misc.lua;
    } // lib.optionalAttrs config.matuz.hyprland.includeMonitorLayout {
      # Keep the workstation layout; portable installs use Hyprland defaults.
      monitors = ./monitors.lua;
      workspaces = ./workspaces.lua;
    };
  };
}
