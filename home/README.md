# Home Manager modules

This directory contains the user-level modules used by [`matuz.nix`](./matuz.nix).
Each subdirectory is a focused module that can be enabled, disabled, or adapted independently. Modules are selectively imported; see `matuz.nix` to distinguish active modules from opt-in modules.

The parent file owns shared Home Manager settings such as the username, home directory, package list, storage links, MIME associations, and module imports.

## Adding a module

1. Create a directory under `home/`.
2. Add `default.nix` with a Home Manager module.
3. Add a README describing what it configures and any required flake input.
4. Import the directory from `matuz.nix`.
5. Validate from the repository root with `nix flake check`.
