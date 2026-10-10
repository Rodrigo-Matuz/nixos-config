# Dotfiles

Personal configurations and dotfiles for the programs I use, including NixOS
and Home Manager. **NixOS installation is optional.** You can browse and reuse
individual program settings without running an installer. This repository is
planned for `Rodrigo-Matuz/dotfiles`, but it is **not public yet**; the website
bootstrap URL is also not live.

The existing `#nixos` flake profile is for my `matuz` workstation only. It has
machine-specific UUIDs, monitors, paths, and service settings. **Do not apply
`#nixos` on another computer.** The separate `#install` profile behind
[`install.sh`](install.sh) accepts a username and optional modules.

## Choose a path

### Fresh NixOS installation (opt-in)

On an **x86_64 UEFI NixOS installer**, partition and format disks yourself,
mount the target root at `/mnt` and EFI system partition at `/mnt/boot`, then
review the bootstrap script and run it as root:

```bash
# After this repository is public, fetch the script from the raw GitHub URL:
curl -fsSLo install.sh https://raw.githubusercontent.com/Rodrigo-Matuz/dotfiles/main/install.sh
less install.sh
sudo bash install.sh --mode iso
```

**The download will fail until the repository is published.** The planned
`https://www.matuz.dev/nixos-installscript` route currently returns 404 and
must be configured separately before using it instead. The script clones the
full Git repository itself; no manual clone is needed. For a local test of a
published checkout, pass `--repo /path/to/dotfiles` (its files must be committed).
It will ask for a username, hostname, time zone, state version, and optional
modules, then dry-build and require `YES` before installing. Set root and user
passwords at its prompts. **It does not partition, format, or mount disks.**
See [fresh-install prerequisites and limitations](install/README.md#fresh-nixos-installation).

### Existing NixOS installation: try it without switching

Run **without sudo** to build a separate NixOS VM. This is the default mode;
it does not activate the configuration on your host:

```bash
# Once published, fetch the raw script as above, inspect it, then:
bash install.sh --mode preview
# Run the VM launcher from the path printed by the script.
```

Before publication, use a **local committed Git checkout** instead:

```bash
bash /path/to/dotfiles/install.sh --mode preview --repo /path/to/dotfiles
```

You need NixOS on x86_64, Git (or network access to fetch it), a working Nix
store, and enough space to build/run the VM. VM preview writes a checkout under
`~/.local/share/dotfiles-preview/portable-config` (or `$XDG_DATA_HOME`) and
builds in the Nix store; it does **not** copy host disk UUIDs, mount partitions,
change `/etc/nixos`, or switch generations. The VM console logs in as the
chosen user. Select only modules compatible with a virtual machine; graphical
and hardware-specific modules may need edits before they work there. Existing
non-NixOS hosts are not supported by this installer. See the
[preview walkthrough and caveats](install/README.md#existing-nixos-try-the-configuration-in-a-vm).

`--mode installed` is a **separate, destructive-to-host-configuration choice**:
it runs `nixos-rebuild switch` and can remove services or change accounts.
It is **not** the way to try the config. Read the
[advanced apply/rollback guidance](install/README.md#existing-nixos-apply-to-the-host-advanced)
first.

## Repository map

| File | Purpose |
| --- | --- |
| [`flake.nix`](flake.nix) | Inputs and separate `#nixos` (personal) / `#install` (portable) outputs |
| [`flake.lock`](flake.lock) | Locked revisions and hashes for inputs |
| [`configuration.nix`](configuration.nix) | Workstation-only NixOS entrypoint |
| [`hardware-configuration.nix`](hardware-configuration.nix) | Workstation hardware; **not reused by the installer** |
| [`partitions.nix`](partitions.nix) | Additional workstation mounts |
| [`home/matuz.nix`](home/matuz.nix) | Workstation Home Manager imports |
| [`home/`](home/) | Focused user-level modules and application dotfiles |
| [`steam/`](steam/) | Optional system-level Steam module |
| [`install/`](install/) | Portable profile, selection and installer details |

## Home Manager modules

The active modules are imported by [`home/matuz.nix`](home/matuz.nix). Other
modules are documented opt-in building blocks.

| Module | Status | Purpose |
| --- | --- | --- |
| `caelestia` | active | Desktop shell, bar, dashboard, lock screen, and wallpaper |
| `cursor` | active | Rem (Re:ZERO) animated XCursor and Hyprcursor theme |
| `devenv` | active | Development-environment tool |
| `dolphin` | active | KDE file manager |
| `desktop-theme` | active | Shared Fantasy icon theme and dark GTK/Qt appearance |
| `mpv` | active | mpv with the ModernZ on-screen controller |
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

## Maintainer: apply the workstation profile

The following commands are **only for the original `matuz` workstation**.
That profile needs its matching hardware configuration, external flake inputs,
and a Hyprland session for desktop-oriented modules. From the repository root:

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
