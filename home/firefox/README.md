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
- On the workstation, uBlock Origin, Dark Reader, DeArrow, Enhancer for YouTube, and Imagus are installed in the profile. `extensions.autoDisableScopes = 0` enables packaged add-ons without a first-run approval prompt.

The complete preference set is in [`settings.nix`](settings.nix). The workstation
uses [`bookmarks.nix`](bookmarks.nix) and [`extensions.nix`](extensions.nix).
**The portable installer instead uses** [`favorites.nix`](favorites.nix) and
[`extensions-portable.nix`](extensions-portable.nix), without copying this
workstation's bookmarks or extension list. The profile path is
`~/.config/mozilla/firefox/ia642mh7.nixos`.

## Customize a portable install

Edit `home/firefox/favorites.nix` in the installed clone to add your own
`{ name = "…"; url = "https://…"; }` entries. For toolbar links, place
entries in a folder with `toolbar = true` and `bookmarks = [ ... ];`.
By default the list is empty, so Firefox manages bookmarks normally.
**Adding entries enables Home Manager's forced bookmarks**: export any existing
browser bookmarks first, because later rebuilds can replace them. Do not paste
Firefox's exported HTML here; Home Manager expects a Nix list.

In `home/firefox/extensions-portable.nix`, comment/uncomment a package name in
the list to remove/add it. Find more names in the pinned
[`firefox-addons`](https://gitlab.com/rycee/nur-expressions/-/tree/master/pkgs/firefox-addons)
input; use the package attribute name, not an add-ons.mozilla.org URL. The
portable default is only uBlock Origin. Close Firefox before rebuilding and
activating the cloned `#install` profile. These files do not change the existing
workstation Firefox profile, which retains its current bookmarks and add-ons.

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
[`bookmarks.nix`](bookmarks.nix) and [`extensions.nix`](extensions.nix)
retain workstation bookmarks/add-ons; [`favorites.nix`](favorites.nix) and
[`extensions-portable.nix`](extensions-portable.nix) are portable overrides;
and [`chrome/`](chrome/) owns CSS.
