{
  description = "NixOS Flakes Dev1ls";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, nixpkgs-unstable, ... }@inputs:
  let
    system = "x86_64-linux";
    
    unstable-overlay = final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true; 
      };
    };

    # Definimos pkgs aquí para que esté disponible para ambos outputs
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
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dev1ls = import ./home.nix;
            # El overlay se pasa a través de la definición de `pkgs` que NixOS usará
            nixpkgs.overlays = [ unstable-overlay ];
          }
        ];
      };
    };
  };
}