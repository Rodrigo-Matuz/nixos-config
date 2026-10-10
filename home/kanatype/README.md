# Kanatype

Optional Home Manager module for [Kanatype](https://github.com/Rodrigo-Matuz/kanatype), a Japanese kana and kanji practice app. The package comes from the [`kanatype` flake input](../../flake.nix), pinned in [`flake.lock`](../../flake.lock).

The workstation currently imports `./kanatype` from [`home/matuz.nix`](../matuz.nix). Comment out that import to opt out; without it Kanatype is not installed. The upstream module defaults to disabled and is imported only by this local wrapper.

The upstream flake currently packages the x86_64 Linux 1.0.0 `.deb`; no local settings or writable config files are managed. See its [Home Manager module](https://github.com/Rodrigo-Matuz/kanatype/blob/main/flake.nix) for the `programs.kanatype` options.
