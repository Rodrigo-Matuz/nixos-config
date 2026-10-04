# Caelestia desktop shell

Installs the Rodrigo-Matuz Caelestia CLI and shell forks from the root flake. The shell is packaged without its bundled CLI; the Home Manager module installs the forked CLI once. Shell surfaces are opaque so the `050505`–`202020` dark palette does not inherit wallpaper luminance. Wallpaper selection does not update theme state.

After applying this configuration and rebuilding, select the fixed scheme **once** on an existing installation (new installations default to it):

```sh
caelestia scheme set --name matuz --flavour default --mode dark
```

The previously saved scheme is retained until this command is run. No system switch is performed by the configuration patch.

## Module

This module is available to be imported by [`../matuz.nix`](../matuz.nix). The implementation lives in [`default.nix`](default.nix).

## Dependencies

`inputs.caelestia-cli` and `inputs.caelestia-shell`

## Customization

Edit `default.nix` and keep this README current when the module's behavior or external inputs change.
