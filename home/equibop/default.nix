{ config, inputs, lib, pkgs, ... }:

let
  # Equibop stores its Equicord settings under ~/.config/Equibop rather than
  # Vesktop's ~/.config/vesktop directory.
  settings = config.programs.vesktop.vencord.settings;
  seed = pkgs.writeText "caelestia-equibop-initial-settings.json" (builtins.toJSON (
    settings // {
      plugins = (settings.plugins or { }) // {
        CaelestiaVoice = ((settings.plugins or { }).CaelestiaVoice or { }) // {
          enabled = true;
        };
      };
    }
  ));
  target = "${config.xdg.configHome}/Equibop/settings/settings.json";
in
{
  home.packages = [
    inputs.equibop.packages.${pkgs.system}.default
  ];

  # Seed a writable settings file once. Existing Equibop settings are never
  # overwritten by Home Manager activation.
  home.activation.seedCaelestiaEquibopSettings = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    if [ ! -e "${target}" ] && [ ! -L "${target}" ]; then
      run mkdir -p "${config.xdg.configHome}/Equibop/settings"
      run install -m 600 "${seed}" "${target}"
    fi
  '';
}
