# Git

Enables Git. The original workstation sets its author name and email in
[`../matuz.nix`](../matuz.nix); the reusable [`default.nix`](default.nix)
**does not inherit them**. For portable installs, the installer optionally asks
for an author name and email and writes them only to that machine's generated
selection. Leaving both blank installs Git without an author identity.

## Upstream and original Nix source

- [Git](https://git-scm.com/) · [source](https://github.com/git/git) — version-control documentation and code.
- [Home Manager Git module](https://github.com/nix-community/home-manager/tree/master/modules/programs) — original Nix module source.
- [Home Manager option reference](https://nix-community.github.io/home-manager/options.xhtml#opt-programs.git.enable) — available options.

## Module

Imported by [`../matuz.nix`](../matuz.nix); implementation is in
[`default.nix`](default.nix). Set `matuz.git.authorName` and
`matuz.git.authorEmail` together to configure another machine declaratively.
