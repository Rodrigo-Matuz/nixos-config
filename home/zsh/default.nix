{ pkgs, ... }:

{
  imports = [
    ./aliases.nix
    ./plugins.nix
  ];

  # Packages
  home.packages = with pkgs; [
    # JavaScript / TypeScript runtime
    bun
  ];

  programs = {
    # -------------------------------------------------------------------------
    # Fuzzy Finder
    # -------------------------------------------------------------------------
    fzf = {
      enable = true;
      enableZshIntegration = true;
      historyWidget.command = "";
    };

    # -------------------------------------------------------------------------
    # Directory Listing
    # -------------------------------------------------------------------------
    lsd = {
      enable = true;
      enableZshIntegration = true;
    };

    # -------------------------------------------------------------------------
    # Directory Navigation
    # -------------------------------------------------------------------------
    zoxide = {
      enable = true;
      enableZshIntegration = true;

      # Replace `cd` with zoxide
      options = [
        "--cmd cd"
      ];
    };

    # -------------------------------------------------------------------------
    # File Manager
    # -------------------------------------------------------------------------
    yazi = {
      enable = true;
      enableZshIntegration = true;
    };

    # -------------------------------------------------------------------------
    # File Colors
    # -------------------------------------------------------------------------
    vivid = {
      enable = true;
      enableZshIntegration = true;

      activeTheme = "molokai";

      themes.molokai = ./custom-molokai.yml;
    };

    # -------------------------------------------------------------------------
    # Development Environment
    # -------------------------------------------------------------------------
    direnv = {
      enable = true;
      enableZshIntegration = true;

      # Automatically load Nix development environments
      nix-direnv.enable = true;
    };

    # -------------------------------------------------------------------------
    # Shell History
    # -------------------------------------------------------------------------
    atuin = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
