# Rem (Re:ZERO) cursor theme

Packages the checked-in Rem cursor conversion and enables it through Home
Manager. The theme contains both XCursor files for GTK/XWayland and compiled
Hyprcursor files for native Wayland clients.

The source cursor set came from the `rem-re-zero_2de03f14ab_VSTHEMES-ORG`
download. The original download did not include a license; verify the creator's
redistribution permission before pushing or publishing these generated assets.
The Windows `.ani` files were converted with
[`ani2xcursor`](https://github.com/yuzujr/ani2xcursor), then converted to the
Hyprcursor format with [`hyprcursor-util`](https://github.com/hyprwm/hyprcursor).

## Upstream and original Nix sources

- [Home Manager cursor options](https://github.com/nix-community/home-manager/tree/master/modules) — source for `home.pointerCursor`.
- [Home Manager option reference](https://nix-community.github.io/home-manager/options.xhtml#opt-home.pointerCursor.enable) — cursor configuration options.
- [`rem_by_blz/`](rem_by_blz/) — generated local package source.

## Module

Imported by [`../matuz.nix`](../matuz.nix); packaging is implemented in
[`default.nix`](default.nix). The active theme name is `rem_by_blz` and its
cursor size is 12.
