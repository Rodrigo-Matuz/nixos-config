# System configuration

The system entrypoint is [`../configuration.nix`](../configuration.nix). This
directory is reserved for system-level documentation and future modules,
separate from Home Manager modules under [`../home`](../home).

## Imported pieces

- [`hardware-configuration.nix`](../hardware-configuration.nix) — generated hardware and boot-device configuration.
- [`partitions.nix`](../partitions.nix) — additional workstation mounts.
- [`steam`](../steam) — Steam service and firewall settings.

## Upstream references

- [NixOS manual](https://nixos.org/manual/nixos/stable/)
- [NixOS module sources](https://github.com/NixOS/nixpkgs/tree/nixos-unstable/nixos/modules)
- [NixOS option search](https://search.nixos.org/options)

Hardware UUIDs, mount points, and service assumptions are specific to the
original workstation.
