# Vesktop and Vencord

Enables Vesktop with a large declarative Vencord preference set and a Hyprland
launcher entry. The settings cover interface fixes, media tools, translation,
privacy toggles, code-block themes, and custom Rich Presence links.

Some values are personal Discord server/channel identifiers and URLs. Replace
them before reusing this module. Compare option names with upstream when
Vencord changes its settings schema.

## Upstream and original Nix sources

- [Vesktop](https://github.com/Vencord/Vesktop) — desktop client.
- [Vencord](https://github.com/Vendicated/Vencord) — plugin framework/settings.
- [Home Manager modules](https://github.com/nix-community/home-manager/tree/master/modules/programs) — open the `vesktop` module directory for the original Nix module.
- [Hyprland](https://github.com/hyprwm/Hyprland)

## Module

Imported by [`../matuz.nix`](../matuz.nix); [`vesktop.lua`](vesktop.lua) is the
Hyprland launcher configuration.
