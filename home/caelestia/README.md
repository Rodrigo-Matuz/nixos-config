# Caelestia desktop shell

Installs Rodrigo-Matuz's forked Caelestia shell and CLI through the root flake.
The shell is used without its bundled CLI, so the matching forked CLI is
installed exactly once. The module configures the bar, dashboard, lock screen,
notifications, quick toggles, wallpaper visualizer, systemd integration, and
monitor-specific behavior.

The local theme uses dark `#050505`–`#202020` surfaces. Kitty and shell layers
retain their configured transparency; wallpaper changes do not regenerate theme
state.

## Existing profile state

After the first rebuild on an existing installation, select the fixed scheme
once if it is not already active:

```sh
caelestia scheme set --name matuz --flavour default --mode dark
```

This changes mutable Caelestia profile state and is intentionally not run by
Nix. The previously saved scheme remains until changed manually.

## Upstream and fork sources

- [Rodrigo-Matuz/shell](https://github.com/Rodrigo-Matuz/shell) — pinned shell fork; GitHub identifies it as forked from the original.
- [Rodrigo-Matuz/cli](https://github.com/Rodrigo-Matuz/cli) — pinned CLI fork.
- [Original Caelestia shell](https://github.com/caelestia-dots/shell)
- [Original Caelestia CLI](https://github.com/caelestia-dots/cli)

## Module

Imported by [`../matuz.nix`](../matuz.nix); implementation is in
[`default.nix`](default.nix). Dependencies are `inputs.caelestia-cli` and
`inputs.caelestia-shell`.
