# Vicinae launcher

Enables Vicinae as a systemd user service, starts it automatically in the
graphical session, and sets `USE_LAYER_SHELL=1` for layer-shell integration.

## Upstream and original Nix sources

- [Vicinae](https://github.com/vicinaehq/vicinae) — launcher, extensions, and configuration reference.
- [Vicinae Nix/Home Manager module](https://github.com/vicinaehq/vicinae/tree/main/nix) — upstream packaging and module source.

## Module

Imported by [`../matuz.nix`](../matuz.nix); implementation is in
[`default.nix`](default.nix). It requires `inputs.vicinae`.
