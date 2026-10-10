{ pkgs, inputs }:

let
  # Evaluate the pinned add-on overlay with Home Manager's nixpkgs instance,
  # so its allowUnfree setting applies to proprietary extensions as well.
  addons = (inputs.firefox-addons.overlays.default pkgs pkgs).firefox-addons;
in
{
  packages = with addons; [
    ublock-origin
    darkreader
    dearrow
    enhancer-for-youtube
    imagus
    # youtube-shorts-block
  ];

  force = true;
}
