{ inputs, ... }:

{

  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  programs.vicinae = {
    enable = true;

    # Theme declared in ../theme/default.nix (matuz-palette).
    themes = import ./theme/default.nix;

    systemd = {
      enable = true;
      autoStart = true;

      environment = {
        USE_LAYER_SHELL = "1";
      };
    };
  };
}
