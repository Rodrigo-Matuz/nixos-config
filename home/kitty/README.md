# Kitty terminal

Enables Kitty with JetBrainsMono Nerd Font, Zsh integration, `0.6` background
opacity, and the checked-in Matuz palette. Settings live in
[`default.nix`](default.nix).

## Upstream and original Nix source

- [Kitty](https://sw.kovidgoyal.net/kitty/) · [source](https://github.com/kovidgoyal/kitty)
- [Home Manager modules](https://github.com/nix-community/home-manager/tree/master/modules/programs) — open the `kitty` module directory for the original Nix module.
- [JetBrains Mono](https://www.jetbrains.com/lp/mono/)

## Module

Imported by [`../matuz.nix`](../matuz.nix); dependency is
`pkgs.nerd-fonts.jetbrains-mono`.
