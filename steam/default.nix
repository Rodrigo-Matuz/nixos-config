{ config, pkgs, ... }:

{
  programs.steam = {
    enable = true;

    # Opt in to these network listeners explicitly if the features are used.
    remotePlay.openFirewall = false;
    # localNetworkGameTransfers.openFirewall = true;
    dedicatedServer.openFirewall = false;
  };

  systemd.user.services.steam = {
    description = "Steam";
    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.steam}/bin/steam -silent -console -nofriendsui";
      Restart = "on-failure";
    };
  };
}
