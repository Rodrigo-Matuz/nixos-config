# LibreWolf

Optional browser profile based on LibreWolf. It adds DuckDuckGo, NixOS search
shortcuts (`@nix` and `@opt`), managed bookmarks, and uBlock Origin.

This module is not active on the workstation. The portable installer can offer
it, or you can enable it on the workstation by moving this folder to
`home/librewolf/` and rebuilding.

Settings are in [`settings.nix`](settings.nix), bookmarks are in
[`bookmarks.nix`](bookmarks.nix), and the add-on comes from the pinned Firefox
add-ons input.

Learn more: [LibreWolf](https://librewolf.net/)
