# Hyprland

Enables Home Manager's Hyprland integration and loads the window-manager
configuration from Lua files.

## Files

`programs.lua` covers applications; `envs.lua` the session environment;
`general.lua` general settings; `monitors.lua` monitor layout;
`workspaces.lua` workspace placement; `keybinds.lua` shortcuts;
`windowrules.lua`/`layerrules.lua` placement; and `misc.lua` remaining settings.
Monitor names and geometry are machine-specific.

## Upstream and original Nix source

- [Hyprland](https://github.com/hyprwm/Hyprland) · [wiki](https://wiki.hypr.land/)
- [Home Manager modules](https://github.com/nix-community/home-manager/tree/master/modules/programs/wayland) — original Hyprland integration.

## Module

Implementation is in [`default.nix`](default.nix) and is imported by
[`../matuz.nix`](../matuz.nix).
