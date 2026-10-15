{ inputs, pkgs, ... }:

let
  helium = inputs.helium.packages.${pkgs.system}.default;
in
{
  # Helium is a user application, like Firefox and the other browsers in this
  # repository. The separate system module only owns Chromium managed policy.
  home.packages = [ helium ];

  # The existing desktop-theme module already supplies the Matuz dark GTK
  # palette. This flag makes Helium's Chromium UI follow that dark appearance.
  home.file.".config/helium-flags.conf".text = ''
    --enable-features=WebUIDarkMode
  '';
}
