# Noctalia shell

Opt-in Noctalia shell configuration with a dark custom `Matuz` palette,
wallpaper support, and monitor-specific bar placement. The palette is installed
at `~/.config/noctalia/palettes/Matuz.json`.

The module expects `inputs.noctalia.homeModules.default`, but the current root
`flake.nix` does not declare that input. Add and lock it before enabling
`./noctalia` in [`../matuz.nix`](../matuz.nix).

## Upstream and original Nix source

- [Noctalia](https://github.com/noctalia-dev/noctalia) — application and configuration reference.
- [Noctalia source tree](https://github.com/noctalia-dev/noctalia/tree/main/nix) — upstream packaging/module reference when available.
- [`palettes/Matuz.json`](palettes/Matuz.json) — local palette.

## Module

Implementation is in [`default.nix`](default.nix); it enables systemd, dark
mode, custom palette, wallpaper handling, and bar placement for `DP-1`, `DP-2`,
and `HDMI-A-1`.
