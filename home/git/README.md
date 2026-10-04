# Git

Enables Git and declares the default author identity used by this workstation.
The identity in [`default.nix`](default.nix) is personal; replace it before
reusing the module.

## Upstream and original Nix source

- [Git](https://git-scm.com/) · [source](https://github.com/git/git) — version-control documentation and code.
- [Home Manager Git module](https://github.com/nix-community/home-manager/tree/master/modules/programs) — original Nix module source.
- [Home Manager option reference](https://nix-community.github.io/home-manager/options.xhtml#opt-programs.git.enable) — available options.

## Module

Imported by [`../matuz.nix`](../matuz.nix); implementation is in
[`default.nix`](default.nix). Additional commented Git preferences can be
enabled there as needed.
