# OBS Studio

Enables OBS Studio with PipeWire audio capture, VA-API encoding, Vulkan
capture, and a Hyprland launcher entry. [`obs.lua`](obs.lua) contains the
launcher; [`default.nix`](default.nix) selects packages and plugins.

## Upstream and original Nix sources

- [OBS Studio](https://obsproject.com/) · [source](https://github.com/obsproject/obs-studio)
- [OBS plugins in nixpkgs](https://github.com/NixOS/nixpkgs/tree/nixos-unstable/pkgs/applications/video/obs-studio/plugins)
- [Home Manager modules](https://github.com/nix-community/home-manager/tree/master/modules/programs) — open the `obs-studio` module directory for the original Nix integration.
- [PipeWire](https://pipewire.org/)

## Module

Imported by [`../matuz.nix`](../matuz.nix); a working Wayland/Hyprland session
is assumed by the launcher.
