# Neovim

Enables Neovim as the default editor and links this directory into
`~/.config/nvim`. It also installs Lua/Luarocks, Lua language tooling, Stylua,
Tree-sitter, C build tools, and common search/file utilities.

[`init.lua`](init.lua) contains the editor and plugin setup; [`plugins/`](plugins/)
contains individual plugin files; and [`default.nix`](default.nix) owns the
package list and Home Manager link. The link is recursive and forced.

## Upstream and original Nix sources

- [Neovim](https://neovim.io/) · [source](https://github.com/neovim/neovim)
- [Home Manager modules](https://github.com/nix-community/home-manager/tree/master/modules/programs) — open the `neovim` module directory for the original Nix module.
- [NvChad](https://github.com/NvChad/NvChad) — separate opt-in module.

## Module

Imported by [`../matuz.nix`](../matuz.nix).
