{ config, pkgs, inputs, ... }:

{
  programs.librewolf = {
    enable = true;

    profiles.default = {
      isDefault = true;
      name = "default";

      settings = import ./settings.nix;

#      userChrome = ./userChrome.css;

      bookmarks = {
        force = true;
        settings = import ./bookmarks.nix;
      };

      search = {
        force = true;

        default = "DuckDuckGo";

        engines = {
          "NixOS Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            definedAliases = [ "@nix" ];
          };

          "NixOS Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            definedAliases = [ "@opt" ];
          };
        };
      };

      extensions = {
        packages = with inputs.firefox-addons.packages.${pkgs.system}; [
          ublock-origin
        ];

        force = true;
      };
    };
  };
}
