{
  description = "Matuz's NixOS configuration";

  # ---------------------------------------------------------------------------
  # Inputs
  # ---------------------------------------------------------------------------
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

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

    nuclear = {
      url = "github:Rodrigo-Matuz/nuclear/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    equibop = {
      url = "github:Rodrigo-Matuz/Equibop";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.caelestia-shell.follows = "caelestia-shell";
    };

  };

  # ---------------------------------------------------------------------------
  # Outputs
  # ---------------------------------------------------------------------------
  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [ ./flake/nixos.nix ];
    };
}
