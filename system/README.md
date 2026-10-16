# System settings

This folder contains system-level pieces for the original workstation. Most
user-facing apps live in [`../home/`](../home/) instead.

## What is here

- [`../configuration.nix`](../configuration.nix) is the workstation's system
  entry point.
- [`../hardware-configuration.nix`](../hardware-configuration.nix) describes
  that machine's hardware and boot device.
- [`../partitions.nix`](../partitions.nix) describes its additional mounts.
- [`../steam/`](../steam/) contains the system-level Steam setup.
- [`chromium-policies.nix`](chromium-policies.nix) supplies browser policies
  used by Helium.

Hardware UUIDs, monitor names, paths, and mount points are machine-specific.
Do not copy them to another computer without reviewing them.

Useful references:
[NixOS manual](https://nixos.org/manual/nixos/stable/) ·
[NixOS option search](https://search.nixos.org/options)
