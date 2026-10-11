# Portable Firefox add-ons: comment a line to remove it, or uncomment to add it.
# Add package names from inputs.firefox-addons (see README.md). Rebuild to apply.
{ pkgs, inputs }:
let
  addons = (inputs.firefox-addons.overlays.default pkgs pkgs).firefox-addons;
in
with addons; [
  ublock-origin
  # darkreader
  # dearrow
  # enhancer-for-youtube
  # imagus
  # youtube-shorts-block
]
