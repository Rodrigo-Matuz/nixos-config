# Matuz Palette — Vicinae theme

This is a **dark** theme for [Vicinae][1], defined as a Nix attribute set so it
can be managed declaratively through the NixOS/home-manager module.

## Palette

| Role  | Hex   | Name        |
| ----- | ----- | ----------- |
| BG    | `#050505` | surface     |
| Red   | `#fc1a70` | danger      |
| Purple| `#702ef3` | primary (soft) |
| Blue  | `#1e65ff` | primary (accent) |
| Orange| `#ff4d00` | warning / error |
| Yellow| `#ffff87` | highlight   |
| Green | `#a4e400` | success     |

## Files

| File | Purpose |
| ---- | ------- |
| `default.nix` | Authoritative theme definition (attribute set of `{ meta, colors }`). |
| `matuz-palette.toml` | The equivalent TOML for reference (what Nix generates). |
| `README.md` | This file. |

The attribute key `matuz-palette` becomes the theme file name
(`matuz-palette.toml`) in Vicinae's theme directory.

## How it is loaded

The NixOS/home-manager module at `../default.nix` declares:

```nix
programs.vicinae.themes = import ./theme/default.nix;
```

On every build this places the generated theme at:

```text
~/.local/share/vicinae/themes/matuz-palette.toml
```

## Using the theme

```sh
# Via CLI
vicinae theme set matuz-palette

# Via GUI: open Vicinae's root search, type "Set Theme", pick it.
```

The theme also inherits the built-in `vicinae-dark` palette for anything you
don't override, so it stays complete even if you only cared about the six
accent colours.

## Note

`vicinae >= 0.15.0` uses the TOML theme format. Older versions use JSON; this
file will not apply to them.

[1]: https://vicinae.com
