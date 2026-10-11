{ config, lib, pkgs, inputs, ... }:

{
  options.matuz.firefox.useWorkstationDefaults = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Import workstation Firefox bookmarks and add-ons";
  };

  config = {
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
        bookmarks = let
          favorites = import ./favorites.nix;
        in if config.matuz.firefox.useWorkstationDefaults then {
          force = true;
          settings = import ./bookmarks.nix;
        } else {
          # Empty portable list leaves browser-managed bookmarks alone.
          force = favorites != [ ];
          settings = favorites;
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
        extensions = if config.matuz.firefox.useWorkstationDefaults then
          import ./extensions.nix { inherit pkgs inputs; }
        else {
          packages = import ./extensions-portable.nix { inherit pkgs inputs; };
          force = true;
        };
      };
    };

    # Remove only Sidebery’s retired Ctrl+B command from an existing profile.
    # Firefox owns the rest of extension-settings.json, so preserve all other keys.
    home.activation.firefoxRemoveSideberyShortcut = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      shortcutFile="$HOME/.config/mozilla/firefox/ia642mh7.nixos/extension-settings.json"
      sideberyId='{3c078156-979c-498b-8990-85f7987dd929}'
      if [ -f "$shortcutFile" ] && ${pkgs.jq}/bin/jq -e --arg id "$sideberyId" \
        'any(.commands._execute_sidebar_action.precedenceList[]?; .id == $id)' "$shortcutFile" >/dev/null; then
        tmpFile="$(${pkgs.coreutils}/bin/mktemp "$shortcutFile.XXXXXX")"
        ${pkgs.coreutils}/bin/chmod 600 "$tmpFile"
        if ${pkgs.jq}/bin/jq --arg id "$sideberyId" '
          .commands._execute_sidebar_action.precedenceList |= map(select(.id != $id))
          | if .commands._execute_sidebar_action.precedenceList == []
            then del(.commands._execute_sidebar_action) else . end
        ' "$shortcutFile" > "$tmpFile"; then
          ${pkgs.coreutils}/bin/mv -f "$tmpFile" "$shortcutFile"
        else
          ${pkgs.coreutils}/bin/rm -f "$tmpFile"
          exit 1
        fi
      fi
    '';
  };
}
