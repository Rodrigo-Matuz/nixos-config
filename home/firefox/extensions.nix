{ pkgs, inputs }:

let
  addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};

  # Enhancer for YouTube is distributed under a non-free custom license. The
  # package is intentionally requested here; override only its Nix metadata so
  # the flake can evaluate it without changing the system-wide unfree policy.
  enhancerForYoutube = addons.enhancer-for-youtube.overrideAttrs (old: {
    meta = old.meta // {
      license = old.meta.license // { free = true; };
    };
  });
in
{
  packages = with addons; [
    ublock-origin
    darkreader
    dearrow
    enhancerForYoutube
    sidebery
    # youtube-shorts-block
  ];

  force = true;
}
