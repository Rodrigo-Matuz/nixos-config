# Try or install the portable NixOS profile

This directory describes the profile used by [`../install.sh`](../install.sh).
It is separate from the original Matuz workstation profile, so the installer
asks about your account and hardware instead of copying mine.

## Pick the mode you need

| Mode | Use it when | Changes the current system? |
| --- | --- | --- |
| `preview` | You want to try the setup in a virtual machine | No |
| `iso` | You booted a NixOS live USB and want a fresh install | Installs to the mounted target |
| `installed` | You already run NixOS and want to replace its profile | Yes, this is the risky option |

If you are unsure, start with `preview`.

## Before starting

- The installer currently supports x86_64 machines.
- Use a trusted checkout or Git URL. The script clones and evaluates that
  repository, so review the source before running it as root.
- Keep a backup of files you care about.
- The script never partitions, formats, or mounts disks.
- In `iso` mode, boot the live system in UEFI mode and mount the target root at
  `/mnt` and its EFI partition at `/mnt/boot`.
- In `installed` mode, the machine must already use systemd-boot with `/boot`
  mounted. This mode keeps the existing account and changes the host profile.

## Download the installer

If you do not already have a checkout, download the small bootstrap script from
this memorable URL, inspect it, and then choose a mode below:

```bash
curl -fsSL https://matuz.dev/nixos-installscript -o install.sh
less install.sh
```

The URL redirects to the `install.sh` file in GitHub. The script then clones the
full repository. If the repository is private or you are testing local changes,
use a committed checkout and pass it with `--repo` instead.

## Try it in a VM

Run this as your normal user, without `sudo`:

```bash
bash /path/to/dotfiles/install.sh \
  --mode preview \
  --repo /path/to/dotfiles
```

The script asks for a username and the apps to include. Press Enter when you
want no optional apps. It then builds a separate NixOS VM and prints a command
to start it. The VM logs in automatically for convenience; your real system is
not switched, `/etc/nixos` is not changed, and host disks are not mounted.

The VM is useful for checking the shape of the profile. It cannot prove that
GPU drivers, monitors, audio devices, or other hardware-specific settings will
work on your machine.

## Install from a NixOS live USB

Prepare the disks yourself, then mount them before running the script:

```bash
sudo mount /dev/<root-partition> /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/<efi-partition> /mnt/boot
sudo bash /path/to/dotfiles/install.sh \
  --mode iso \
  --repo /path/to/dotfiles
```

The script asks for:

- the new username, hostname, time zone, and NixOS state version;
- whether the first console should log in automatically;
- the Home Manager and system modules to install;
- an optional Git author name and email;
- optional existing data partitions to mount.

Press Enter at an optional question to choose the safe default. The script
shows a dry-build before it asks for the final `YES`. It asks for root and user
passwords after the installation finishes. Reboot only after both passwords are
set and the installation reports success.

The new configuration is saved at `/etc/nixos/portable-config` on the target.

## Apply it to an existing NixOS installation

This mode is for people who have already reviewed the profile and have a way
back to their current system. It is not a preview:

```bash
sudo bash /path/to/dotfiles/install.sh \
  --mode installed \
  --repo /path/to/dotfiles
```

The script copies the current machine's hardware configuration, keeps the
existing `/etc/nixos` files, and switches the new profile only after a dry-build
and an explicit confirmation. It can still stop services, replace user-managed
application files, or leave you needing to boot an older generation. Check that
you can recover your current NixOS generation before using this mode.

## Choosing apps

The installer finds active modules in `home/<name>/` and opt-in modules in
`home/optional/<name>/`. Select numbers from the list, separated by spaces or
commas. Press Enter to select none.

A few combinations are deliberately rejected:

- choose either `nvim` or `nvchad`;
- choose either `caelestia` or `noctalia`;
- selecting `wallpaper` automatically adds `caelestia` and Hyprland, because
  Wallpaper Picker uses Caelestia to apply the selected wallpaper;
- selecting `caelestia` also adds `hyprland` automatically;
- Noctalia is shown only after its missing flake input is added.

Many desktop modules were written for the original workstation. Read their
README before selecting them on different hardware.

## Optional data drives

The installer can offer existing, already-formatted data partitions. This is
not disk setup: it does not create filesystems or recover data. If you do not
recognize a partition, answer `no` or type `skip`.

Choosing a data partition gives the selected user access to the mount root and
can change that directory's ownership. Back up important data and check the
mount names before confirming. The generated mounts use UUIDs and are allowed
to be absent at boot, so an unplugged data drive should not block startup.

## After installation

For a fresh install, the profile is already active. For an existing system, the
same profile can be rebuilt later with:

```bash
sudo nixos-rebuild switch \
  --flake /etc/nixos/portable-config#install
```

To return to an earlier NixOS generation, use the boot menu or, while the
current system still works:

```bash
sudo nixos-rebuild switch --rollback
```

Sign in to GitHub, Hermes, Discord, browsers, and other apps after installation.
The installer does not need API keys or password files and does not copy the
workstation owner's credentials.

## Trusting a particular revision

For a remote source, you can pin the branch or tag and check the exact commit:

```bash
sudo bash install.sh --mode iso \
  --repo https://example.invalid/dotfiles.git \
  --ref <tag-or-branch> \
  --expect-revision <40-character-commit-sha>
```

Replace the example URL and placeholders with values you have verified. A tag
or branch can move; checking the full commit gives you a fixed source. Do not
run an installer from a source you do not trust.

See the repository [README](../README.md) for the module layout and the
workstation commands.
