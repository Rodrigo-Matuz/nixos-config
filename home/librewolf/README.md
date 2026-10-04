# LibreWolf

Opt-in LibreWolf profile with DuckDuckGo, NixOS search shortcuts, forced
bookmarks, and uBlock Origin. Settings are in [`settings.nix`](settings.nix),
bookmarks in [`bookmarks.nix`](bookmarks.nix), and the extension comes from the
`inputs.firefox-addons` package set.

Search shortcuts are `@nix` for [NixOS Packages](https://search.nixos.org/packages)
and `@opt` for [NixOS Options](https://search.nixos.org/options).

## Upstream and original Nix sources

- [LibreWolf](https://librewolf.net/) · [source](https://codeberg.org/librewolf/source)
- [Home Manager program modules](https://github.com/nix-community/home-manager/tree/master/modules/programs) — open the `librewolf` module directory for the original Nix module.
- [Home Manager LibreWolf options](https://nix-community.github.io/home-manager/options.xhtml#opt-programs.librewolf.enable)
- [Firefox add-on packages](https://gitlab.com/rycee/nur-expressions/-/tree/master/pkgs/firefox-addons)

## Module

Imported by [`../matuz.nix`](../matuz.nix) only when enabled; implementation is
in [`default.nix`](default.nix).
