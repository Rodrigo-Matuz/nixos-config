# Rust toolchain

Installs the Rust compiler and the usual tools:

- `rustc` and `cargo`;
- `rustfmt` and Clippy;
- `rust-analyzer` for editor integration.

This is a global toolchain. Project-specific native libraries and build settings
belong in a project `flake.nix` or `devenv.nix`. Cargo keeps its normal cache in
your home directory.

The module is active on the workstation and can be selected in a portable
profile.
