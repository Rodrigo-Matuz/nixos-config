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

`obs-control.sh` reads an optional WebSocket password from
`$XDG_CONFIG_HOME/obs-studio/websocket-password` (or `~/.config/...`), which
should be mode `0600` and never committed. It passes the connection URL through
`OBS_WEBSOCKET_URL`, not process arguments. The password is still visible to
processes that can inspect the same user's environment; treat that user as one
trust boundary. If the file is absent, the control shortcut fails with a clear
message, but OBS installation itself does not require a password.
