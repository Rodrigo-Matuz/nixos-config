{ inputs, pkgs, ... }:

let
  hyprKeybinds = inputs.vicinae.lib.${pkgs.stdenv.hostPlatform.system}.mkVicinaeExtension {
    pname = "hypr-keybinds";
    name = "hypr-keybinds";
    version = "unstable-2026-07-02";
    src = pkgs.fetchFromGitHub {
      owner = "vicinaehq";
      repo = "extensions";
      rev = "5d1d31a698d5ac0b25b7391fcce3d920cd9c552e";
      hash = "sha256-u9QmD1FnLf+64o60L4ldx81m88eeK5/EgNYTEAt9qIo=";
    } + "/extensions/hypr-keybinds";
  };

in
{

  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  programs.vicinae = {
    enable = true;

    # Declarative Hyprland keybind viewer (search for "Show Hyprland Keybinds").
    extensions = [ hyprKeybinds ];

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
