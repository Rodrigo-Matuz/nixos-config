# Home Manager modules

This directory contains focused user-level modules imported by
[`matuz.nix`](matuz.nix). The parent file owns shared settings such as the
username, home directory, package list, storage links, MIME associations, and
module imports.

Each module README describes its behavior, dependencies, machine-specific
assumptions, and upstream/original Nix source. Read it together with the local
`default.nix` before changing an option.

## Adding a module

1. Create a directory under `home/`.
2. Add `default.nix` with a Home Manager module.
3. Add a README with behavior, dependencies, upstream links, and caveats.
4. Import it from `matuz.nix` and mark it active or opt-in in the root README.
5. Validate from the repository root:

   ```bash
   nix flake check --no-write-lock-file
   nixos-rebuild dry-build --flake .#nixos --no-write-lock-file
   ```
