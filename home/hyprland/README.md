# Hyprland

Enables Home Manager's Hyprland integration and loads the window-manager
configuration from Lua files.

## Files

`programs.lua` covers applications; `envs.lua` the session environment;
`general.lua` general settings; `monitors.lua` monitor layout;
`workspaces.lua` workspace placement; `keybinds.lua` shortcuts;
`windowrules.lua`/`layerrules.lua` placement; and `misc.lua` remaining settings.
Monitor names and geometry are machine-specific. The workstation imports
`monitors.lua` and `workspaces.lua`; the portable installer omits both so
Hyprland uses its defaults. After installation, edit the cloned profile’s
`home/hyprland/monitors.lua` (and, if needed, `workspaces.lua`) and enable
`matuz.hyprland.includeMonitorLayout = true;` in `install/portable.nix`
for that profile, then rebuild it. Other selected modules may still reference
workstation outputs.

## Upstream and original Nix source

- [Hyprland](https://github.com/hyprwm/Hyprland) · [wiki](https://wiki.hypr.land/)
- [Home Manager modules](https://github.com/nix-community/home-manager/tree/master/modules/programs/wayland) — original Hyprland integration.

## Module

Implementation is in [`default.nix`](default.nix) and is imported by
[`../matuz.nix`](../matuz.nix).
