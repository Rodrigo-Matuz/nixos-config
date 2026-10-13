{ config, pkgs, ... }:

{
  programs.copilot = {
    enable = true;
    shellIntegration = true;
  };

  # Optional: make `copilot` binary available in user environment
  environment.systemPackages = with pkgs; [
    github-copilot
  ];
}
