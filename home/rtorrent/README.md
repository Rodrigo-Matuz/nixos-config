# rtorrent

Enables the rtorrent Home Manager program using the nixpkgs package. This
module only declares the program; download directories, trackers, and network
policy remain runtime/user configuration.

## Upstream and original Nix sources

- [rtorrent](https://rakshasa.github.io/rtorrent/) · [source](https://github.com/rakshasa/rtorrent) — client documentation and code.
- [Home Manager rtorrent module](https://github.com/nix-community/home-manager/tree/master/modules/programs) — original Nix module source.
- [nixpkgs rtorrent package](https://github.com/NixOS/nixpkgs/tree/nixos-unstable/pkgs/by-name/rt/rtorrent) — package used here.

## Module

Imported by [`../matuz.nix`](../matuz.nix); implementation is in
[`default.nix`](default.nix).
