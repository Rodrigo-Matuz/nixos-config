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

## Keybind descriptions and language

Keybind descriptions are shown by the Vicinae Hyprland keybind viewer. They
use English by default and switch to Brazilian Portuguese when the session
locale starts with `pt_BR` or `pt-BR`.

On NixOS, change the locale in `configuration.nix`:

```nix
i18n.defaultLocale = "pt_BR.UTF-8";
```

Then rebuild the system and restart Hyprland (or log out and back in). To use
English again, set it back to `en_US.UTF-8` and restart Hyprland.

## Upstream and original Nix source

- [Hyprland](https://github.com/hyprwm/Hyprland) · [wiki](https://wiki.hypr.land/)
- [Home Manager modules](https://github.com/nix-community/home-manager/tree/master/modules/programs/wayland) — original Hyprland integration.

## Module

Implementation is in [`default.nix`](default.nix) and is imported by
[`../matuz.nix`](../matuz.nix).
