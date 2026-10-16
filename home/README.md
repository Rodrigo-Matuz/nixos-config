# Apps and user settings

Each folder here describes one app or one small group of user settings. Home
Manager applies the active folders when the system is rebuilt.

## Active and optional modules

- A folder directly under `home/` with a `default.nix` is active on the original
  workstation.
- A folder under [`optional/`](optional/) is not active there, but the portable
  installer can offer it during setup.
- The installer writes the selected apps to its local `install/selection.nix`.
  It does not change the workstation profile.

You can therefore turn off an app without editing a long list elsewhere:

```bash
git mv home/<app> home/optional/<app>
sudo nixos-rebuild switch --flake .#nixos
```

Move it back when you want it again. Removing a folder completely also removes
its settings from future generations, but keeps old generations available for a
rollback.

## Adding a module

Create:

```text
home/<app>/default.nix
home/<app>/README.md
```

The module will be discovered automatically. If it needs a flake input, add and
lock that input in `flake.nix`, then import the input's Home Manager module from
`default.nix`. Keep the README focused on what a user gets, what the module
assumes, and how to customize it.

For an app that should be opt-in, use `home/optional/<app>/` instead. Optional
modules are still available to the portable installer.

## Before rebuilding

Check the whole configuration first:

```bash
nix flake check
sudo nixos-rebuild dry-build --flake .#nixos
```

The workstation modules assume a graphical Wayland session and the original
machine in a few places. Read an app's README before selecting it for another
computer.
