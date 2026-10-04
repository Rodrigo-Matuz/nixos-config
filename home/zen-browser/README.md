# Zen Browser

Opt-in Home Manager module for Zen Browser. The module only enables the
browser; profile preferences are intentionally left to Zen's own user-facing
configuration.

## Upstream and original Nix source

- [Zen Browser flake](https://github.com/0xc000022070/zen-browser-flake) — flake and Home Manager module consumed by this configuration.
- [Zen Browser website](https://zen-browser.app/) — browser documentation and downloads.

## Module

Imported by [`../matuz.nix`](../matuz.nix) when enabled; implementation is in
[`default.nix`](default.nix) and requires `inputs.zen-browser`.
