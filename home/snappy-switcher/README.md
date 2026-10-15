# Snappy Switcher

Installs [Snappy Switcher](https://github.com/OpalAayan/snappy-switcher) from
its upstream flake, starts its daemon as a systemd user service, and configures
the Hyprland `Alt+Tab` binding.

## Theme

The managed theme uses the fixed Matuz/Caelestia palette:

- Red `#FC1A70`
- Purple `#702EF3`
- Blue `#1E65FF`
- Orange `#FF4D00`
- Yellow `#FFFF87`
- Green `#A4E400`
- Background `#050505` at 60% opacity (`#05050599`)

The generated files are:

- `~/.config/snappy-switcher/config.ini`
- `~/.config/snappy-switcher/themes/matuz.ini`

The active binding is `Alt+Tab`; it replaces the previous Hyprland binding that
used `Alt+Tab` for monitor switching.

## Module

Imported by [`../matuz.nix`](../matuz.nix); implementation is in
[`default.nix`](default.nix). The package is provided by the
`inputs.snappy-switcher` flake input.
