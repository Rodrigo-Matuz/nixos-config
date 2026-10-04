# Wayland screenshots

Installs Grim, Grimblast, Slurp, Satty, and wl-clipboard for capture, region
selection, annotation, and clipboard workflows. These tools expect a working
Wayland session and are available as separate commands rather than a wrapper
script.

## Upstream and original Nix sources

- [grim](https://gitlab.freedesktop.org/emersion/grim) — Wayland screenshot tool.
- [slurp](https://github.com/emersion/slurp) — interactive region selector.
- [grimblast](https://github.com/hyprwm/contrib/tree/main/grimblast) — screenshot workflow helper.
- [Satty](https://github.com/gabm/Satty) — screenshot annotation tool.
- [wl-clipboard](https://github.com/bugaevc/wl-clipboard) — Wayland clipboard utilities.
- [nixpkgs package search](https://search.nixos.org/packages?query=grim) — package versions and metadata.

## Module

Imported by [`../matuz.nix`](../matuz.nix); implementation is in
[`default.nix`](default.nix).
