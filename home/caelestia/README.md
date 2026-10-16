# Caelestia desktop

Active desktop shell for the workstation. It provides the bar, dashboard,
notifications, lock screen, quick toggles, wallpaper visualizer, and session
services, using the Matuz dark theme.

It is set up around the original workstation's displays and uses Kitty, Dolphin,
mpv, and PipeWire tools for its launch actions. The wallpaper folder is
`~/Pictures/Wallpapers`. If you use this module on another computer, review the
monitor names and application commands in [`default.nix`](default.nix).

After the first rebuild, choose the Matuz scheme once if Caelestia has not
already created it:

```bash
caelestia scheme set --name matuz --flavour default --mode dark
```

The command changes Caelestia's own user state; Nix does not run it for you.

This module is active because it lives directly under `home/`. To make it
optional, move it to `home/optional/` and rebuild. The shell comes from
[Rodrigo-Matuz/shell](https://github.com/Rodrigo-Matuz/shell) and its CLI comes
from [Rodrigo-Matuz/cli](https://github.com/Rodrigo-Matuz/cli).
