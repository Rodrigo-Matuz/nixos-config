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

    helium = {
      url = "github:tomsch/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snappy-switcher = {
      url = "github:OpalAayan/snappy-switcher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hermes-agent.url = "github:NousResearch/hermes-agent";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    resonance = {
      url = "github:Rodrigo-Matuz/Resonance";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nuclear = {
      url = "github:Rodrigo-Matuz/nuclear/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  # ---------------------------------------------------------------------------
  # Outputs
  # ---------------------------------------------------------------------------
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    localResonanceDeb =
      let path = builtins.getEnv "RESONANCE_LOCAL_DEB";
      in if path == "" then null else builtins.path { path = path; name = "resonance-local-deb"; };
    resonancePackage = if localResonanceDeb != null
      then inputs.resonance.packages.${system}.default.overrideAttrs (_: {
        # Local testing path. The artifact is supplied through an environment
        # variable by Resonance/scripts/nixos-local-test.sh and is never added
        # to this repository or committed to the NixOS configuration.
        src = localResonanceDeb;
      })
      else inputs.resonance.packages.${system}.default;
  in
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
        inputs.sops-nix.nixosModules.sops
        ./secrets.nix

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
            inputs.resonance.homeManagerModules.default
          ];

          home-manager.users.matuz.programs.resonance = {
            enable = true;
            package = resonancePackage;
          };
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
