{ config, lib, pkgs, inputs, ... }:

let
  firefoxExtensionSettings = builtins.toFile "firefox-extension-settings.json" (builtins.toJSON {
    version = 3;
    commands = {
      "_execute_sidebar_action" = {
        initialValue = {};
        precedenceList = [
          {
            id = "{3c078156-979c-498b-8990-85f7987dd929}";
            installDate = 0;
            value = { shortcut = "Ctrl+B"; };
            enabled = true;
          }
        ];
      };
    };
  });
in
{
  # https://mynixos.com/home-manager/options/programs.firefox.profiles.%3Cname%3E
  home.file.".config/mozilla/firefox/ia642mh7.nixos/chrome".source = ./chrome;

  programs.firefox = {
    # configPath = ".mozilla";
    enable = true;
    languagePacks = [ "en-US" "pt-BR" ];
    profiles.nixos = {
      id = 0;
      name = "nixos";
      isDefault = true;
      path = "ia642mh7.nixos";
      settings = import ./settings.nix;
      bookmarks = {
        force = true;
        settings = import ./bookmarks.nix;
      };
      search = {
        force = true;
        default = "ddg";
        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "NixOS Wiki" = {
            urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
            icon = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };
        };
      };
      extensions = import ./extensions.nix {
        inherit pkgs inputs;
      };
    };
  };

  # Sidebery owns Ctrl+B and toggles its left tab sidebar.
  home.activation.firefoxExtensionShortcuts =
    lib.hm.dag.entryAfter [ "writeBoundary" ]
      "test -e $HOME/.config/mozilla/firefox/ia642mh7.nixos/extension-settings.json || install -Dm644 ${firefoxExtensionSettings} $HOME/.config/mozilla/firefox/ia642mh7.nixos/extension-settings.json";
}
