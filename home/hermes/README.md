# Hermes Agent

Enables the Hermes Agent desktop application and service with a local backend on port 9119, memory, and the configured model provider.

## Module

This module is available to be imported by [`../matuz.nix`](../matuz.nix). The implementation lives in [`default.nix`](default.nix).

## Dependencies

The Hermes Agent Home Manager module; runtime credentials come from `/var/lib/hermes/env` and are not stored here

## Customization

Edit `default.nix` and keep this README current when the module's behavior or external inputs change.
