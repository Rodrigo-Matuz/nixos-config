# Steam system module

Enables Steam at the NixOS system level, opens the firewall ports needed for remote play and dedicated servers, and starts Steam as a user service when the graphical session becomes available.

The module is imported by [`configuration.nix`](../configuration.nix) through `./steam`.
