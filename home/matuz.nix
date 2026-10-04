{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hyprland
    ./zsh
    ./kitty
    ./caelestia
    ./vicinae
    ./obs
    ./vesktop
    ./wallpaper
    ./screenshot
    ./fastfetch
    ./nvim
    ./cursor
    ./rtorrent
    ./nvtop
    ./termusic
    ./firefox
    ./git
    ./devenv
    ./vscodium
    ./hermes
  ];

  # ---------------------------------------------------------------------------
  # Package overlays
  # ---------------------------------------------------------------------------
  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
    # inputs.ytm-player.overlays.default
  ];

  # ---------------------------------------------------------------------------
  # Home
  # ---------------------------------------------------------------------------
  home.username = "matuz";
  home.homeDirectory = "/home/matuz";
  home.stateVersion = "26.05";

  # Storage HD directories
  home.activation.storageHdLinks = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sfn "/mnt/storage_hd/OBS Videos" "$HOME/Videos"
    ln -sfn "/mnt/storage_hd/Pictures" "$HOME/Pictures"
    ln -sfn "/mnt/storage_hd/Wallpapers" "$HOME/Wallpapers"
    ln -sfn "/mnt/workspace_linux/Repos" "$HOME/Repos"
  '';

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
    };

    associations.added = {
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
    };
  };

  xdg.configFile."mimeapps.list".force = true;
  # ---------------------------------------------------------------------------
  # User Packages
  # ---------------------------------------------------------------------------
  home.packages = with pkgs; [
    # CLI / Development
    ripgrep
    fd
    bat
    btop

    # Applications
    zathura

    # System
    thunar
  ];

  # ---------------------------------------------------------------------------
  # Git
  # ---------------------------------------------------------------------------
  programs.git = {
    enable = true;
  };

  # ---------------------------------------------------------------------------
  # Home Manager
  # ---------------------------------------------------------------------------
  programs.home-manager.enable = true;
}
