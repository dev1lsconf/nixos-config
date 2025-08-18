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
      };
    };

    # pkgs aquí para para ambos outputs
    pkgs = import nixpkgs {
      inherit system;
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
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.dev1ls = import ./home.nix;
          }
        ];
      };
    };
  };
}
