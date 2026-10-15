# Nuclear

Active Home Manager module imported from [`../matuz.nix`](../matuz.nix).
It enables `programs.nuclear-music-player` from the Nuclear flake at
`/mnt/workspace_linux/Repos/nuclear` declared in [`../../flake.nix`](../../flake.nix).
The local flake repackages the pinned upstream x86_64 `.deb`; its version/hash
are not updated automatically. Run `nix flake check` and a NixOS dry-build
before switching to a changed Nuclear release. This local path will not work
on another machine until replaced with a published fork input.
