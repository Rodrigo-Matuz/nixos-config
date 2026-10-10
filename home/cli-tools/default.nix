{ pkgs, ... }: {
  # Shared command-line utilities, independent of desktop applications.
  home.packages = with pkgs; [ ripgrep fd bat btop ];
}
