{ pkgs, ... }:

{
  # Keep the Rust toolchain in Home Manager so it follows the user's
  # development environment instead of being installed system-wide.
  home.packages = with pkgs; [
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
  ];
}
