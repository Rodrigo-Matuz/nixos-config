# NixOS configuration

Personal NixOS and Home Manager configuration for the `matuz` workstation.
The setup uses a flake, keeps system and user modules separate, and runs Hyprland with a collection of desktop and development tools.

## Layout

```text
.
├── flake.nix                  # Inputs and the nixosConfigurations output
├── configuration.nix          # System entrypoint
├── hardware-configuration.nix # Generated hardware configuration
├── partitions.nix             # Additional machine-specific mounts
├── system/                    # Documentation for system-level configuration
├── home/matuz.nix             # Home Manager entrypoint and module imports
├── home/<module>/             # Individual Home Manager modules
└── steam/                     # System-level Steam module
```

### Home Manager modules

The **active** modules are imported by `home/matuz.nix`. The remaining modules are kept as opt-in building blocks and are not enabled by default.

| Module | Status | Purpose |
| --- | --- | --- |
| `caelestia` | active | Desktop shell, bar, wallpaper, dashboard, and utilities |
| `cursor` | active | Installs and enables the bundled NieR cursor theme |
| `devenv` | active | Installs `devenv` |
| `dolphin` | opt-in | Installs the Dolphin file manager |
| `fastfetch` | active | Enables Fastfetch and its JSONC configuration |
| `firefox` | active | Firefox profile, bookmarks, search engines, and browser chrome |
| `git` | active | Git identity and program configuration |
| `hermes` | active | Hermes Agent desktop service and local backend |
| `hyprland` | active | Lua-based Hyprland configuration |
| `kitty` | active | Kitty terminal, font, colors, and shell integration |
| `librewolf` | opt-in | LibreWolf profile, bookmarks, search engines, and extensions |
| `noctalia` | opt-in | Noctalia shell and custom palette; requires its flake input |
| `nvim` | active | Neovim, development tools, and Lua configuration |
| `nvchad` | opt-in | NvChad Home Manager module |
| `nvtop` | active | AMD GPU monitoring tool |
| `obs` | active | OBS Studio and capture plugins |
| `rtorrent` | active | rtorrent Home Manager program |
| `screenshot` | active | Wayland screenshot and annotation tools |
| `snappy-switcher` | opt-in | Installs the Snappy Switcher flake package; requires its flake input |
| `termusic` | active | Installs termusic |
| `vesktop` | active | Vesktop/Vencord configuration and Hyprland launcher |
| `vicinae` | active | Vicinae launcher service |
| `vscodium` | active | VSCodium settings, theme, icons, and extensions |
| `wallpaper` | opt-in | Wallpaper Picker UI and wallpaper application command |
| `zsh` | active | Zsh tools, aliases, plugins, and shell integrations |
| `zen-browser` | opt-in | Enables Zen Browser |

## Requirements

- NixOS on `x86_64-linux`
- Flakes and the `nix` command enabled
- Git, if cloning the repository
- A machine-specific `hardware-configuration.nix`
- The external flake inputs referenced by `flake.nix`

This configuration enables unfree packages and assumes a Hyprland session. Several modules also assume the monitor names, mount points, and storage layout of the original workstation.

## Apply the configuration

From a checkout of this repository:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

To test without switching the active system:

```bash
sudo nixos-rebuild test --flake .#nixos
```

To update flake inputs deliberately:

```bash
nix flake update
sudo nixos-rebuild switch --flake .#nixos
```

Keep `flake.lock` committed so rebuilds use reviewed, reproducible input revisions.

## Machine-specific files and privacy

- `hardware-configuration.nix` contains filesystem UUIDs generated for one machine.
- `partitions.nix` contains additional filesystem UUIDs and mount points for that machine.
- `home/matuz.nix` contains the workstation's storage paths and user name.
- `home/hermes/hermes-profile.gz` is local profile data and must not be committed. It is ignored by `.gitignore`.
- Replace personal identity, paths, monitor names, and service settings before reusing this configuration on another machine.

No secrets should be stored in this repository. Use environment files, a secret manager, or another encrypted mechanism for credentials.
