# /etc/nixos/flake.nix
{
  description = "NixOS Flakes Dev1ls";

  # 1. Entradas (Inputs)
  # Aquí defines las dependencias de tu sistema.
  # La más importante es 'nixpkgs', que contiene todos los paquetes.
  inputs = {
    # Usamos la rama estable de NixOS 25.05
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    
    # (Opcional, pero muy común) Home Manager para gestionar la configuración de usuario
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05"; # Usa la versión compatible
      inputs.nixpkgs.follows = "nixpkgs"; # Asegura que use la misma versión de nixpkgs
    };

    # Añadimos Hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # 2. Salidas (Outputs)
  # Aquí defines lo que tu Flake "produce". En este caso, una configuración de NixOS.
  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs: {

    # La configuración de tu sistema NixOS
    nixosConfigurations = {
      # ¡¡IMPORTANTE!! Cambia "mi-nixos-pc" por el hostname real de tu máquina.
      # Puedes ver tu hostname con el comando `hostname`.
      thinkcentre = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; # O "aarch64-linux" para ARM
        specialArgs = { inherit inputs; }; # Permite acceder a los inputs en otros archivos
        modules = [
          # El archivo principal de tu configuración
          ./configuration.nix
          
          # (Opcional) Integra el módulo de Home Manager para todo el sistema
          home-manager.nixosModules.home-manager
        ];
      };
      
      # Puedes añadir más máquinas aquí si gestionas varias
      # otro-pc = nixpkgs.lib.nixosSystem { ... };
    };
  };
}
