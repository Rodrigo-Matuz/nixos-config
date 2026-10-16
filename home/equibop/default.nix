{ inputs, pkgs, ... }:

{
  # Equibop is kept separate from the existing Vesktop module.
  home.packages = [
    inputs.equibop.packages.${pkgs.system}.default
  ];
}
