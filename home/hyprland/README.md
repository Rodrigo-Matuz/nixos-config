# Hyprland

Enables Hyprland and loads the window-manager settings stored in this folder.
The files cover the session environment, applications, monitors, workspaces,
shortcuts, window rules, and layer rules.

Monitor and workspace layouts describe the original workstation. The portable
profile leaves those layouts out by default, so Hyprland can use the new
computer's own display settings. If you later want to manage them, edit
`monitors.lua` and `workspaces.lua` in the generated profile and enable the
portable layout option.

The keybind viewer uses English unless the session locale starts with `pt_BR` or
`pt-BR`. The module is active on the workstation and is automatically added by
the installer when Caelestia is selected.

Learn more: [Hyprland](https://hyprland.org/)
