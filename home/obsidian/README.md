# Obsidian

Installs [Obsidian](https://obsidian.md/) from pinned nixpkgs via Home Manager.
The workstation imports this module from [`home/matuz.nix`](../matuz.nix);
remove the import to uninstall it. The portable installer offers it independently.
This proprietary package needs `nixpkgs.config.allowUnfree = true`, already set
for the workstation and portable profile. Vaults, account and plugins remain
user-managed; this module does not create, import or synchronize any vault.
See [nixpkgs source](https://github.com/NixOS/nixpkgs/tree/master/pkgs/by-name/ob/obsidian).
