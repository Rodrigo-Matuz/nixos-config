# Helium

Installs the Helium Chromium companion browser through Home Manager, alongside
the active Firefox module. The package comes from the pinned
[`helium-nix`](https://github.com/tomsch/helium-nix) flake input because Helium
is not in nixpkgs.

The workstation's Firefox bookmarks are converted into Chromium managed
bookmarks, and the compatible Chromium extensions are installed by the small
system policy bridge in [`../../system/chromium-policies.nix`](../../system/chromium-policies.nix).
That bridge is system-level because Chromium does not reliably consume the same
policies from a Home Manager user policy directory.

Helium's built-in uBlock Origin fork covers Firefox's uBlock Origin entry; it is
not duplicated as a second extension. Imagus is represented by its maintained
Chromium port, Imagus Reborn.

The existing Matuz dark GTK theme is shared automatically, and
