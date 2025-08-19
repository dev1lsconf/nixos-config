{
  description = "NixOS Flakes Dev1ls";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, ... }@inputs:
  let
    system = "x86_64-linux";
    
    unstable-overlay = final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true; 
      };
    };

    # pkgs aquí para para ambos outputs
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [ unstable-overlay ];
    };

  in {
    nixosConfigurations = {
      thinkcentre = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        pkgs = pkgs;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
