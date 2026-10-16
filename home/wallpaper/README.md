# Wallpaper Picker UI

Active wallpaper picker for the workstation. It scans `~/Wallpapers`, lets you
choose an image or video, and runs the Caelestia wallpaper command in the
background when you apply the selection.

The current settings are:

- English interface;
- dark mode;
- new-wallpaper scanning enabled;
- debug mode enabled for the current setup.

The command used for applying a selection is kept in
[`default.nix`](default.nix), where `$VP` is replaced by the selected path. This
module depends on Caelestia, but it is not a replacement for the Caelestia shell.
When the portable installer sees `wallpaper`, it adds `caelestia` and Hyprland
for you. Caelestia and Noctalia are the two mutually exclusive shell choices.

Create `~/Wallpapers` before opening the app. Learn more at the
[Wallpaper Picker UI repository](https://github.com/Rodrigo-Matuz/wallpaper-picker-ui).
