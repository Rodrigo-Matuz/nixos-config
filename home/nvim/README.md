# Neovim

Makes Neovim the default editor and links this folder to `~/.config/nvim`.
It includes the editor plugins plus Lua tooling, Stylua, Tree-sitter, C build
tools, and common search utilities.

Edit [`init.lua`](init.lua) and [`plugins/`](plugins/) to change the editor. The
configuration is linked recursively, so changes in this checkout are picked up
on the next activation.

This is the workstation's active Neovim setup. The separate NvChad module is
optional; do not install both in the portable profile.
