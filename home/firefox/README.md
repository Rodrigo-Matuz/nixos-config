# Firefox

Enables Firefox with the `nixos` profile, English and Brazilian Portuguese language packs, bookmarks, NixOS search engines, and custom browser chrome.

## Module

This module is available to be imported by [`../matuz.nix`](../matuz.nix). The implementation lives in [`default.nix`](default.nix).

## Dependencies

`settings.nix`, `bookmarks.nix`, `chrome/`, and `extensions.nix`

## Customization

Edit `default.nix` and keep this README current when the module's behavior or external inputs change.

## Tab sidebar and shortcut

[`Sidebery`](https://github.com/mbnuqw/sidebery) provides the left-hand tab
sidebar. Press **Ctrl+B** to open or close it. The shortcut is initialized through
Firefox's `extension-settings.json` (an existing file is preserved), so Firefox's normal bookmarks-sidebar
binding is replaced for this profile. When the sidebar is closed, the existing
horizontal tab strip remains available as a fallback.

Sidebery's settings are intentionally left user-configurable; open its sidebar
once with **Ctrl+B**, then use its panel settings to choose flat or tree tabs and
adjust the width if needed.
