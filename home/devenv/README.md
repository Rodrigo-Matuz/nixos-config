# devenv

Installs the `devenv` development-environment tool as a Home Manager package.
Project-specific environments are still defined by each project's own
`devenv.nix` or `devenv.yaml`.

## Upstream and original Nix source

- [devenv.sh](https://devenv.sh/) · [source](https://github.com/cachix/devenv) — tool documentation and implementation.
- [nixpkgs devenv package](https://github.com/NixOS/nixpkgs/tree/nixos-unstable/pkgs/by-name/de/devenv) — package used by this module.

## Module

Imported by [`../matuz.nix`](../matuz.nix); implementation is in
[`default.nix`](default.nix).
