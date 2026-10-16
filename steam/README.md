# Steam

This module installs Steam at the system level and starts it when the graphical
session is ready. Steam's Remote Play and dedicated-server firewall ports stay
closed by default.

Enable those network exceptions only if you need them. The settings are in
[`default.nix`](default.nix).

This is a system module, so it is selected separately by the portable installer.
For the original workstation it is imported from
[`../configuration.nix`](../configuration.nix).

Learn more: [Steam](https://store.steampowered.com/) ·
[NixOS Steam options](https://search.nixos.org/options?query=programs.steam)
