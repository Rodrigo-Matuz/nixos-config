# Zsh shell

Configures the Zsh environment used by the workstation. It enables fzf, lsd,
zoxide, yazi, vivid with a custom Molokai theme, direnv with nix-direnv, Atuin,
and Bun. Zsh aliases and plugin declarations are kept in
[`aliases.nix`](aliases.nix) and [`plugins.nix`](plugins.nix).

## Upstream projects

- [Zsh](https://www.zsh.org/) — shell.
- [fzf](https://github.com/junegunn/fzf) · [lsd](https://github.com/lsd-rs/lsd) · [zoxide](https://github.com/ajeetdsouza/zoxide) — interactive shell tools.
- [Yazi](https://github.com/sxyazi/yazi) · [Vivid](https://github.com/sharkdp/vivid) — file manager and file-color tools.
- [direnv](https://direnv.net/) · [nix-direnv](https://github.com/nix-community/nix-direnv) — environment loading.
- [Atuin](https://github.com/atuinsh/atuin) · [Bun](https://bun.sh/) — history and JavaScript tooling.
- [Home Manager Zsh module](https://github.com/nix-community/home-manager/tree/master/modules/programs) — original Nix integration.

## Module

Imported by [`../matuz.nix`](../matuz.nix); implementation is in
[`default.nix`](default.nix). The custom theme is
[`custom-molokai.yml`](custom-molokai.yml).
