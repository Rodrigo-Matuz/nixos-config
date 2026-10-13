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
    (pkgs.writeTextFile {
      name = "github-copilot-token";
      text = "GITHUB_TOKEN=gho_Si...gVAt";
      destination = "/home/matuz/.github-copilot-token";
      executable = false;
    })
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

  # Add GitHub Copilot token to zsh environment
  home.file = {
    ".zshenv".text = ''
      export GITHUB_TOKEN="gho_Si...gVAt"
    '';
  };
}
