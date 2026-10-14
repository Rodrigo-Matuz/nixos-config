{
  description = "Matuz's NixOS configuration";

  # ---------------------------------------------------------------------------
  # Inputs
  # ---------------------------------------------------------------------------
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      url = "github:Rodrigo-Matuz/shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.caelestia-cli.follows = "caelestia-cli";
    };

    caelestia-cli = {
      url = "github:Rodrigo-Matuz/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vicinae.url = "github:vicinaehq/vicinae";

    ytm-player.url = "github:peternaame-boop/ytm-player";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hermes-agent.url = "github:NousResearch/hermes-agent";

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpaper-picker-ui = {
      url = "github:Rodrigo-Matuz/wallpaper-picker-ui";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kanatype = {
      url = "github:Rodrigo-Matuz/kanatype";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  # ---------------------------------------------------------------------------
  # Outputs
  # ---------------------------------------------------------------------------
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit inputs;
      };

      modules = [
        {
          nixpkgs.overlays = [
            inputs.nix-vscode-extensions.overlays.default
          ];
        }

        ./configuration.nix

        { nixpkgs.config.allowUnfree = true; }

        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };

          home-manager.users.matuz.imports = [
            inputs.caelestia-shell.homeManagerModules.default
            inputs.caelestia-shell.homeManagerModules.vesktop-voice
            inputs.zen-browser.homeModules.default
            inputs.hermes-agent.homeManagerModules.default
            inputs.wallpaper-picker-ui.homeManagerModules.default
          ];
        }
      ];
    };

    # Portable profile used by install.sh; leave the workstation output intact.
    nixosConfigurations.install = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./install/portable.nix ];
    };
  };
}
