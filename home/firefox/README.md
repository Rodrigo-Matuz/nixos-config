# Firefox

Declares the workstation's `nixos` Firefox profile with Home Manager. It
installs English and Brazilian Portuguese language packs, forced bookmarks,
NixOS search shortcuts, declarative extensions, and custom browser chrome from
[`chrome/`](chrome/).

## What is configured

- DuckDuckGo is the default search engine.
- `@np` searches [Nix Packages](https://search.nixos.org/packages); `@nw` searches the [NixOS Wiki](https://nixos.wiki/).
- Strict Enhanced Tracking Protection and HTTPS-only mode are enabled.
- Camera, microphone, and location access ask before granting permission.
- Firefox telemetry, Pocket, sponsored content, and sponsored top sites are disabled.
- Cookies remain enabled so website sessions persist.
- Compact density and CSS customization are enabled.
- uBlock Origin, Dark Reader, DeArrow, Enhancer for YouTube, and Imagus are installed in the profile. `extensions.autoDisableScopes = 0` enables packaged add-ons without a first-run approval prompt.

The complete preference set is in [`settings.nix`](settings.nix), bookmarks are
in [`bookmarks.nix`](bookmarks.nix), and extensions are in
[`extensions.nix`](extensions.nix). The profile path is
`~/.config/mozilla/firefox/ia642mh7.nixos`.

## Add-ons and mutable profile state

[Imagus](https://addons.mozilla.org/firefox/addon/imagus/) previews linked images
on hover. Firefox owns session data and user-managed add-on state. Close Firefox
before activating Home Manager changes if it is writing profile data. The
activation step removes only the obsolete Sidebery Ctrl+B shortcut entry from
existing Firefox profiles; it preserves all other shortcut and add-on settings.

When the address-bar search suggestions open, their background is opaque; the
rest of the FoxOne theme remains unchanged.

## Upstream and original Nix sources

- [Home Manager program modules](https://github.com/nix-community/home-manager/tree/master/modules/programs) — open the `firefox` module directory there for the original Nix module and option implementation.
- [Home Manager Firefox options](https://nix-community.github.io/home-manager/options.xhtml#opt-programs.firefox.profiles) — generated option reference.
- [Firefox](https://www.mozilla.org/firefox/) · [Mozilla source](https://github.com/mozilla-firefox/firefox)
- [Firefox add-on packages](https://gitlab.com/rycee/nur-expressions/-/tree/master/pkgs/firefox-addons) — source for `inputs.firefox-addons`.
- [Imagus](https://addons.mozilla.org/firefox/addon/imagus/) — image hover previews.
- [Firefox CSS hacks](https://github.com/MrOtherGuy/firefox-csshacks) — browser-chrome CSS reference.

## Module files

[`default.nix`](default.nix) owns profile/search/extension setup and shortcut
activation; [`settings.nix`](settings.nix) owns preferences;
[`bookmarks.nix`](bookmarks.nix) owns bookmarks; [`extensions.nix`](extensions.nix)
owns add-ons; and [`chrome/`](chrome/) owns CSS.
