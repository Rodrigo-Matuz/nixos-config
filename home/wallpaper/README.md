# Wallpaper Picker UI

Enables [Wallpaper Picker UI](https://github.com/Rodrigo-Matuz/wallpaper-picker-ui)
through its Home Manager module. It scans `~/Wallpapers`; applying a selection
runs `mpvpaper` with looped, audio-free playback.

## Configuration

| Option | Value |
| --- | --- |
| `wallpapersPath` | `${HOME}/Wallpapers` |
| `command` | `${pkgs.mpvpaper}/bin/mpvpaper -o "loop no-audio" "*" "$VP"` |
| `debugMode` / `newWallpapers` / `darkMode` | `false` / `true` / `true` |
| `language` | `eng` |

`$VP` is replaced with the selected file path. Create `~/Wallpapers` before
opening the app. The backend command is kept in Nix so it can be replaced
without changing the application.

## Upstream and original Nix source

- [Wallpaper Picker UI repository](https://github.com/Rodrigo-Matuz/wallpaper-picker-ui) — application, flake, and Home Manager module.
- [Wallpaper Picker UI `flake.nix`](https://github.com/Rodrigo-Matuz/wallpaper-picker-ui/blob/main/flake.nix) — original module definition.
- [mpvpaper](https://github.com/GhostNaN/mpvpaper) — Wayland backend invoked here.
- [Home Manager](https://github.com/nix-community/home-manager) — module framework.

## Module

Imported by [`../matuz.nix`](../matuz.nix) and implemented in
[`default.nix`](default.nix). It is currently **opt-in**; enable `./wallpaper`
after confirming the input and wallpaper directory are available.
