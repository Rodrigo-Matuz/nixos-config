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
    ./copilot
  ];

  # Package overlays
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
    # inputs.ytm-player.overlays.default
  ];

  # Home
  home.username = "matuz";
  home.homeDirectory = "/home/matuz";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    libsecret
    (pkgs.writeShellScriptBin "copilot-login" ''
      #!/run/current-system/sw/bin/bash
      # Set GITHUB_TOKEN from gh CLI credentials
      export GITHUB_TOKEN="$(gh auth token)"
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

  # Add GITHUB_TOKEN to shell environment from gh CLI credentials
  home.file = {
    ".zshenv".text = ''
      # Use GitHub CLI's secure credential store for Copilot tokens
      if command -v gh &>/dev/null; then
        export GITHUB_TOKEN="$(gh auth token 2>/dev/null)"
      fi
    '';
  };
}
