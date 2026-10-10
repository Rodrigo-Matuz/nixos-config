# Home Manager modules

This directory contains focused user-level modules imported by
[`matuz.nix`](matuz.nix). The parent file owns shared settings such as the
username, home directory, machine-specific storage links, and module imports.
Applications and shared CLI packages live in individual modules; Dolphin owns
its directory MIME association.

Each module README describes its behavior, dependencies, machine-specific
assumptions, and upstream/original Nix source. Read it together with the local
`default.nix` before changing an option.

## Adding a module

1. Create a directory under `home/`.
2. Add `default.nix` with a Home Manager module.
3. Add a README with behavior, dependencies, upstream links, and caveats.
4. Add an import in `matuz.nix` for workstation activation, or leave a commented
   import for opt-in use. The portable installer discovers module directories
   automatically; check [`install/portable.nix`](../install/portable.nix) if the
   module needs an additional flake input. Update its status in the root README.
5. Validate from the repository root:

   ```bash
   nix flake check --no-write-lock-file
   nixos-rebuild dry-build --flake .#nixos --no-write-lock-file
   ```
