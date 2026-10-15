# Nuclear

Active Home Manager module imported from [`../matuz.nix`](../matuz.nix).
It enables `programs.nuclear-music-player` from
[Rodrigo Matuz’s personal fork](https://github.com/Rodrigo-Matuz/nuclear),
declared in [`../../flake.nix`](../../flake.nix) via its lightweight `nix`
branch (only `flake.nix` and `flake.lock`). The fork repackages the pinned
[upstream](https://github.com/nukeop/nuclear) x86_64 `.deb`; its version/hash
are not updated automatically. Run `nix flake check` and a NixOS
dry-build before switching to a changed Nuclear release.
