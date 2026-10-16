# Helium browser

Installs the Helium Chromium-based browser and enables its dark interface. The
package comes from the pinned `helium-nix` input because it is not supplied by
nixpkgs here.

The workstation also supplies Chromium policies so compatible browser settings
and extensions can follow the Firefox setup. Helium's built-in uBlock fork is
used instead of installing a second copy.

This module installs the browser, not your accounts, history, or passwords. It
is active on the workstation.

Learn more: [Helium](https://github.com/imputnet/helium)
