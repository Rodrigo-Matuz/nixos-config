# Dolphin file manager

Installs KDE Dolphin as a user package together with Ark for archive handling,
FFmpeg and KDE graphics thumbnail providers, and Qt image format plugins.
Desktop integration and mounted-volume behavior are provided by the surrounding
KDE/Wayland session rather than this module.

## Upstream and original Nix source

- [Dolphin](https://apps.kde.org/dolphin/) · [source](https://invent.kde.org/system/dolphin) — file manager documentation and code.
- [nixpkgs Dolphin package](https://github.com/NixOS/nixpkgs/tree/nixos-unstable/pkgs/kde-apps/dolphin) — package used here.

## Module

Active module imported from [`../matuz.nix`](../matuz.nix);
implementation is in [`default.nix`](default.nix).

## Theme

The module installs and selects [`MatuzDark.colors`](MatuzDark.colors), based
on the Matuz design tokens from `matuz.dev`.
