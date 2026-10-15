# Steam system module

Enables Steam at the NixOS system level and starts Steam as a user service
when the graphical session becomes available. Remote Play and dedicated-server
firewall exceptions are **off by default**; opt in to the corresponding
`programs.steam.remotePlay.openFirewall` or
`programs.steam.dedicatedServer.openFirewall` setting only if needed. See [`default.nix`](default.nix) for the
service command and firewall options.

## Upstream and original Nix sources

- [Steam](https://store.steampowered.com/) · [Steam for Linux](https://github.com/ValveSoftware/steam-for-linux)
- [NixOS Steam module](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/programs/steam.nix)
- [NixOS firewall options](https://search.nixos.org/options?query=networking.firewall)

Imported by [`configuration.nix`](../configuration.nix) through `./steam`.
