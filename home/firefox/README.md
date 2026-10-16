# Firefox

Sets up the workstation Firefox profile with:

- DuckDuckGo and shortcuts for NixOS Packages (`@np`) and the NixOS Wiki
  (`@nw`);
- strict tracking protection and HTTPS-only mode;
- English and Brazilian Portuguese language packs;
- managed bookmarks, extensions, and the local browser theme;
- a few privacy and appearance preferences.

Workstation bookmarks and extensions live in [`bookmarks.nix`](bookmarks.nix)
and [`extensions.nix`](extensions.nix). The portable installer uses the safer,
separate [`favorites.nix`](favorites.nix) and
[`extensions-portable.nix`](extensions-portable.nix), so it does not copy the
workstation's personal browser data. Edit those portable files in a generated
install if you want to add your own bookmarks or extensions.

Close Firefox before applying profile changes. Existing profile data remains
user data, so back it up before changing forced bookmarks or settings.

This module is active on the workstation. See [Firefox](https://www.mozilla.org/firefox/)
for browser documentation.
