{ lib, inputs, pkgs, ... }:

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
    ./helium
    ./git
    ./devenv
    ./rust
    ./dolphin
    ./cli-tools
    ./obsidian
    ./zathura
    ./desktop-theme
    ./mpv
    ./vscodium
    ./hermes
    ./kanatype
    ./nuclear
    ./copilot
  ];

  # Package overlays
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
    # inputs.ytm-player.overlays.default
  ];

  # Workstation Git identity; the portable installer collects its own.
  matuz.git.authorName = "Rodrig-Matuz";
  matuz.git.authorEmail = "rodrigosantoslima1311@gmail.com";

  # Home
  home.username = "matuz";
  home.homeDirectory = "/home/matuz";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    libsecret
    (pkgs.writeShellScriptBin "copilot-login" ''
      if [ "$#" -eq 0 ]; then
        printf 'Usage: copilot-login COMMAND [ARGS...]\n' >&2
        exit 2
      fi
      # Scope the token to the requested command, not every login shell.
      token=$(gh auth token) || {
        printf 'Authenticate with gh auth login first.\n' >&2
        exit 1
      }
      export GITHUB_TOKEN="$token"
      unset token
      exec "$@"
    '')
  ];

  # Storage HD directories
  home.activation.storageHdLinks = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    link_storage() {
      source="$1"
      target="$2"
      if [ -e "$target" ] && [ ! -L "$target" ]; then
        printf 'Skipping storage link: %s exists and is not a symlink\n' "$target" >&2
        return
      fi
      run ln -sfnT "$source" "$target"
    }
    link_storage "/mnt/storage_hd/OBS Videos" "$HOME/Videos"
    link_storage "/mnt/storage_hd/Pictures" "$HOME/Pictures"
    link_storage "/mnt/storage_hd/Wallpapers" "$HOME/Wallpapers"
    link_storage "/mnt/workspace_linux/Repos" "$HOME/Repos"
  '';

  # Home Manager
  programs.home-manager.enable = true;
}
