# VSCodium

Enables VSCodium with the Sweet Dracula Monokai theme, Catppuccin icons,
JetBrainsMono Nerd Font, trusted schema domains, and development extensions.
Settings and extensions are declared in [`default.nix`](default.nix).

The `open` workspace-trust choice and broad schema allowlist are deliberate
workstation preferences; review them before reusing this module.

## Upstream and original Nix sources

- [VSCodium](https://vscodium.com/) · [source](https://github.com/VSCodium/vscodium)
- [Home Manager modules](https://github.com/nix-community/home-manager/tree/master/modules/programs) — open the `vscode` module directory for the original Nix module.
- [nix-vscode-extensions](https://github.com/nix-community/nix-vscode-extensions)
- [Sweet Dracula Monokai](https://github.com/LEFD/sweetdracula-monokai) · [Catppuccin icons](https://github.com/catppuccin/vsc-icons)

## Module

Imported by [`../matuz.nix`](../matuz.nix). The overlay is configured in
[`../../flake.nix`](../../flake.nix).
