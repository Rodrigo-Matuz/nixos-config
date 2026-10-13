{ config, pkgs, ... }:

{
  # GitHub Copilot CLI (command-line interface)
  programs.github-copilot-cli = {
    enable = true;
  };

  # Binary package in the user environment (home.packages, not system packages)
  home.packages = with pkgs; [
    github-copilot-cli
  ];
}
