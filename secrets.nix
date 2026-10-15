# Workstation-only encrypted secrets. The portable installer never imports this.
# Enabling this option requires a tracked encrypted secrets/hermes.enc and
# a root-owned age identity at /var/lib/sops-nix/key.txt on this workstation.
{ config, lib, ... }:
let
  cfg = config.matuz.secrets.hermes;
in
{
  options.matuz.secrets.hermes.enable = lib.mkEnableOption "encrypted Hermes API credentials";

  config = lib.mkIf cfg.enable {
    sops.age.keyFile = "/var/lib/sops-nix/key.txt";
    sops.secrets."hermes-env" = {
      sopsFile = ./secrets/hermes.enc;
      format = "dotenv";
      key = "";
      owner = "matuz";
      mode = "0400";
    };
    # System decryption precedes Home Manager activation. Hermes also copies
    # the decrypted values to its persistent .env; see secrets/README.md.
    home-manager.users.matuz.services.hermes-agent.environmentFiles = [
      config.sops.secrets."hermes-env".path
    ];
  };
}
