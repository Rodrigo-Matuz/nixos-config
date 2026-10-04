# NvChad

Opt-in module that enables the NvChad Home Manager module from `nix4nvchad`.
It is separate from the active custom Neovim module.

## Upstream and original Nix sources

- [NvChad](https://github.com/NvChad/NvChad) — editor configuration framework.
- [nix4nvchad](https://github.com/nix-community/nix4nvchad) — Nix/Home Manager integration used by this module.
- [Neovim](https://neovim.io/) — editor runtime.

## Module

Imported by [`../matuz.nix`](../matuz.nix) when enabled; implementation is in
[`default.nix`](default.nix) and requires `inputs.nix4nvchad`.
