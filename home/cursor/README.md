# NieR cursor theme

Packages the checked-in `NieR_Cursors_2020-08-25.tar.xz` archive and enables it
for GTK and X11 through Home Manager. The archive is vendored because its
original download/source URL is not recorded in this repository; inspect the
archive license and provenance before redistributing it.

## Upstream and original Nix sources

- [Home Manager cursor options](https://github.com/nix-community/home-manager/tree/master/modules) — source for `home.pointerCursor`.
- [Home Manager option reference](https://nix-community.github.io/home-manager/options.xhtml#opt-home.pointerCursor.enable) — cursor configuration options.
- [`NieR_Cursors_2020-08-25.tar.xz`](NieR_Cursors_2020-08-25.tar.xz) — local package source.

## Module

Imported by [`../matuz.nix`](../matuz.nix); packaging is implemented in
[`default.nix`](default.nix).
