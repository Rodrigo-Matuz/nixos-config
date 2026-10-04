# Snappy Switcher

Opt-in package module for the default Snappy Switcher output from
`inputs.snappy-switcher`. The current root flake does not declare that input;
add and lock the input before enabling this directory.

## Upstream and original Nix source

The upstream repository URL is not declared in the current flake, so this
README intentionally does not guess it. Once the input is added, document its
canonical repository URL in [`../../flake.nix`](../../flake.nix) and here.

## Module

Imported by [`../matuz.nix`](../matuz.nix) when enabled; implementation is in
[`default.nix`](default.nix) and expects `inputs.snappy-switcher`.
