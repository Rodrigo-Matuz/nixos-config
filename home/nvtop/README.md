# nvtop

Installs the AMD-specific `nvtop` package for GPU monitoring. Use `nvtop` from
a terminal inside the graphical session to inspect utilization, memory, and
processes supported by the GPU backend.

## Upstream and original Nix source

- [nvtop](https://github.com/Syllo/nvtop) — monitor documentation and source.
- [nixpkgs nvtop packages](https://github.com/NixOS/nixpkgs/tree/nixos-unstable/pkgs/by-name/nv/nvtop) — package set used here.

## Module

Imported by [`../matuz.nix`](../matuz.nix); implementation is in
[`default.nix`](default.nix) and selects `pkgs.nvtopPackages.amd`.
