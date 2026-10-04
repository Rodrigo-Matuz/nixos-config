{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.packages = with pkgs; [
    # Lua
    lua
    luarocks
    lua-language-server
    stylua

    # Tree-sitter
    tree-sitter

    # Build tools
    gcc
    gnumake

    # General tooling
    ripgrep
    fd
    git
    curl
    unzip
  ];

  xdg.configFile."nvim" = {
    source = ./.;
    recursive = true;
    force = true;
  };
}
