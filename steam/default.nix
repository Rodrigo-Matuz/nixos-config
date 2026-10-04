{ config, pkgs, ... }:

{
  programs.steam = {
    enable = true;

    remotePlay.openFirewall = true;
    # localNetworkGameTransfers.openFirewall = true;
    dedicatedServer.openFirewall = true;
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
