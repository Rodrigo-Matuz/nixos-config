# Matuz NixOS configuration

Personal NixOS and Home Manager configuration for the `matuz` workstation. This
flake targets one `x86_64-linux` machine and contains machine-specific UUIDs,
monitor names, mount points, user paths, and service settings.

## Start here

| File | Purpose |
| --- | --- |
| [`flake.nix`](flake.nix) | Inputs and the `nixosConfigurations.nixos` output |
| [`flake.lock`](flake.lock) | Locked revisions and hashes for inputs |
| [`configuration.nix`](configuration.nix) | NixOS system entrypoint |
| [`hardware-configuration.nix`](hardware-configuration.nix) | Generated hardware/filesystem configuration |
| [`partitions.nix`](partitions.nix) | Additional workstation mounts |
| [`home/matuz.nix`](home/matuz.nix) | Home Manager entrypoint and imports |
| [`home/`](home/) | Focused user-level modules |
| [`steam/`](steam/) | System-level Steam module |

## Home Manager modules

The active modules are imported by [`home/matuz.nix`](home/matuz.nix). Other
modules are documented opt-in building blocks.

| Module | Status | Purpose |
| --- | --- | --- |
| `caelestia` | active | Desktop shell, bar, dashboard, lock screen, and wallpaper |
| `cursor` | active | Bundled NieR cursor theme |
| `devenv` | active | Development-environment tool |
| `dolphin` | opt-in | KDE file manager |
| `fastfetch` | active | Fastfetch and JSONC configuration |
| `firefox` | active | Profile, preferences, bookmarks, extensions, and CSS |
| `git` | active | Git identity and program settings |
| `hermes` | active | Hermes Agent application and local backend |
| `hyprland` | active | Lua-based window-manager configuration |
| `kitty` | active | Terminal, font, shell integration, and palette |
| `librewolf` | opt-in | LibreWolf profile and uBlock Origin |
| `noctalia` | opt-in | Noctalia shell and Matuz palette |
| `nvim` | active | Neovim and development tooling |
| `nvchad` | opt-in | NvChad Home Manager module |
| `nvtop` | active | AMD GPU monitoring |
| `obs` | active | OBS Studio and capture plugins |
| `rtorrent` | active | rtorrent Home Manager program |
| `screenshot` | active | Wayland screenshot/annotation tools |
| `termusic` | active | Terminal music player |
| `vesktop` | active | Vesktop/Vencord preferences |
| `vicinae` | active | Vicinae launcher service |
| `vscodium` | active | VSCodium settings, theme, icons, and extensions |
| `wallpaper` | opt-in | Wallpaper Picker UI and mpvpaper integration |
| `zsh` | active | Zsh tools, aliases, plugins, and integrations |
| `zen-browser` | opt-in | Zen Browser module |

## Upstream and source references

The input declarations in [`flake.nix`](flake.nix) and revisions in
[`flake.lock`](flake.lock) are authoritative. Read the local module README for
component-specific links.

- [NixOS/nixpkgs](https://github.com/NixOS/nixpkgs) · [NixOS manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager](https://github.com/nix-community/home-manager) · [module sources](https://github.com/nix-community/home-manager/tree/master/modules)
- [Caelestia fork: shell](https://github.com/Rodrigo-Matuz/shell) · [CLI](https://github.com/Rodrigo-Matuz/cli)
- [Wallpaper Picker UI](https://github.com/Rodrigo-Matuz/wallpaper-picker-ui)
- [Hermes Agent](https://github.com/NousResearch/hermes-agent)
- [Vicinae](https://github.com/vicinaehq/vicinae)
- [Zen Browser flake](https://github.com/0xc000022070/zen-browser-flake)
- [Firefox add-on packages](https://gitlab.com/rycee/nur-expressions/-/tree/master/pkgs/firefox-addons)
- [VSCodium extensions overlay](https://github.com/nix-community/nix-vscode-extensions)

## Requirements and apply

- NixOS on `x86_64-linux`, flakes enabled, and Git.
- A machine-specific hardware configuration.
- The external flake inputs declared in `flake.nix`.
- A Hyprland session for desktop-oriented modules.

From the repository root:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

Validate without switching:

```bash
nix flake check --no-write-lock-file
sudo nixos-rebuild dry-build --flake .#nixos --no-write-lock-file
```

Update inputs deliberately, review the lockfile, and commit it:

```bash
nix flake update
sudo nixos-rebuild switch --flake .#nixos
```

## Machine-specific files and privacy

`hardware-configuration.nix`, `partitions.nix`, and `home/matuz.nix` contain
machine-specific UUIDs, paths, and user settings. `home/hermes/hermes-profile.gz`
and build output are ignored. Do not store secrets here; use environment files,
a secret manager, or encrypted storage.
