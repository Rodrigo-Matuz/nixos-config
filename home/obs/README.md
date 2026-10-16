# OBS Studio

Installs OBS Studio with PipeWire audio capture, VA-API encoding, Vulkan
capture, the Hyprland launcher, and the Matuz theme.

The theme is [`Matuz.ovt`](Matuz.ovt). The launcher is in [`obs.lua`](obs.lua).
The module expects a working Wayland/Hyprland session and is tuned for the
original display setup, so review it before using it elsewhere.

OBS control shortcuts can use a local WebSocket password file at
`~/.config/obs-studio/websocket-password`. Keep that file mode `0600` and never
commit it. OBS itself does not need the file to start.

The module is active on the workstation and can be selected in the portable
profile.
