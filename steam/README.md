# Steam system module

Enables Steam at the NixOS system level, opens the firewall ports needed for
Remote Play and dedicated servers, and starts Steam as a user service when the
graphical session becomes available. See [`default.nix`](default.nix) for the
service command and firewall options.

## Upstream and original Nix sources

- [Steam](https://store.steampowered.com/) · [Steam for Linux](https://github.com/ValveSoftware/steam-for-linux)
- [NixOS Steam module](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/programs/steam.nix)
- [NixOS firewall options](https://search.nixos.org/options?query=networking.firewall)

Imported by [`configuration.nix`](../configuration.nix) through `./steam`.
