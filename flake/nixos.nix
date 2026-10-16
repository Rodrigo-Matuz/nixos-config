{ inputs, ... }:

{
  flake.nixosConfigurations = {
    # The original machine-specific workstation profile.
    nixos = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ../configuration.nix
        inputs.sops-nix.nixosModules.sops
        ../secrets.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };

    # Portable profile consumed by install.sh. It remains separate from the
    # workstation so generated hardware and user selections cannot leak into it.
    install = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ../install/portable.nix ];
    };
  };
}
