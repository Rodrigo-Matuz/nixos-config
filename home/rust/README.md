# Rust

Active Home Manager module for the Rust development toolchain. It installs the
Rust compiler, Cargo, `rustfmt`, Clippy, and `rust-analyzer` from the pinned
Nixpkgs input:

- `rustc` — Rust compiler
- `cargo` — package manager and build tool
- `rustfmt` — formatter
- `clippy` — linter
- `rust-analyzer` — language server

The module is imported by [`home/matuz.nix`](../matuz.nix), so the tools are
available in Matuz's user environment after a Home Manager/NixOS activation.
Cargo still stores downloaded registry data and build artifacts in the user's
normal Cargo directories (usually `~/.cargo` and `target/`).

For projects that need native libraries or a reproducible per-project build
environment, add a project-specific `flake.nix`/`devenv.nix`; this module only
provides the global command-line toolchain.
