# NixOS setup and dotfiles

This repository contains a personal NixOS and Home Manager setup. It is also a
collection of small app configurations: you can copy an app module without
adopting the whole desktop.

## Choose a starting point

| What you want | Start here |
| --- | --- |
| Try the setup without changing your computer | [`install/README.md`](install/README.md), then `install.sh --mode preview` |
| Install it from a NixOS live USB | [`install/README.md`](install/README.md), then `install.sh --mode iso` |
| Use it on an existing NixOS installation | Read the warning in [`install/README.md`](install/README.md) before `--mode installed` |
| Rebuild the original Matuz workstation | `sudo nixos-rebuild switch --flake .#nixos` |
| Browse individual app settings | [`home/`](home/) |

The installer works with a trusted Git checkout as well as a remote Git URL:

```bash
bash /path/to/dotfiles/install.sh --mode preview --repo /path/to/dotfiles
```

The source checkout must have a commit. The installer makes its own clone so it
can leave the source directory alone.

Once the repository is public, the short download URL is:

```bash
curl -fsSL https://matuz.dev/nixos-installscript -o install.sh
less install.sh
```

The URL redirects to the installer in the GitHub repository. Keep `-L` so curl
follows that redirect, and read the script before running it as root.

## Important before you use it

- The `#nixos` profile belongs to the original Matuz workstation. It contains
  that machine's hardware, disks, monitors, paths, and user settings. Do not
  apply it to another computer.
- Use `#install` through `install.sh` for a new machine or another user's
  machine. It asks for the username, hostname, time zone, and apps instead of
  assuming mine.
- The installer does not partition, format, or mount disks for you. In a fresh
  install, prepare and mount `/mnt` and `/mnt/boot` first.
- Back up important data before changing a system configuration. The preview
  mode is the safest way to see what the portable profile looks like.
- No password or API key is needed to install the configuration. Sign in to
  apps such as GitHub, Hermes, Firefox, or Discord after installation.

## Adding and removing apps

The app folders are the source of truth:

- `home/<name>/default.nix` means the app is active on the workstation.
- `home/optional/<name>/default.nix` means the app is available to the
  installer but is not active on the workstation.

To remove an app from the workstation while keeping its configuration:

```bash
git mv home/<name> home/optional/<name>
sudo nixos-rebuild switch --flake .#nixos
```

To add it back, move the folder to `home/<name>/`. You do not need to edit a
central import list. The next rebuild discovers the folder automatically.

To add a new app, create `home/<name>/default.nix`. Put an app you are still
testing, or one that should only be offered during installation, under
`home/optional/<name>/` instead. Keep any flake-specific import inside that
app's own module.

## Common commands

Run these from the repository root:

```bash
# Check the configuration without changing the system
nix flake check
sudo nixos-rebuild dry-build --flake .#nixos

# Apply the original workstation profile
sudo nixos-rebuild switch --flake .#nixos
```

The portable installer keeps its generated configuration at
`/etc/nixos/portable-config` after a real installation. Rebuild it later with:

```bash
sudo nixos-rebuild switch --flake /etc/nixos/portable-config#install
```

## Where things live

- [`flake.nix`](flake.nix) and [`flake.lock`](flake.lock): package sources and
  pinned versions.
- [`configuration.nix`](configuration.nix): the original workstation's system
  settings.
- [`home/`](home/): user applications and their settings.
- [`system/`](system/): system-level pieces and hardware notes.
- [`install/`](install/): the portable profile used by the installer.
- [`secrets/`](secrets/): optional encrypted-secret setup; it is not needed by
  the installer.

For module-specific notes, open the README inside that module. Those pages tell
you what the module changes, what it assumes, and where to customize it.

## Links

- [NixOS manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager](https://nix-community.github.io/home-manager/)
- [flake-parts](https://flake.parts/)
