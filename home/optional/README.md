# Optional apps

These modules are ready to try, but they are not part of the original
workstation by default. The portable installer lists them separately with the
active modules.

To enable one on the workstation, move its folder up one level and rebuild:

```bash
git mv home/optional/<app> home/<app>
sudo nixos-rebuild switch --flake .#nixos
```

Read the app's README first. Some optional modules need a desktop session or a
specific flake input, and Noctalia still needs its input wired into the flake
before it can be enabled.
