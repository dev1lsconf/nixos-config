{
  description = "NixOS Flakes Dev1ls";

  # 1. Entradas (Inputs)
  # Aquí defines las dependencias de tu sistema.
  # La más importante es 'nixpkgs', que contiene todos los paquetes.
  inputs = {
    # Usamos la rama estable de NixOS 25.05
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    
    # Añadimos nixpkgs-unstable para paquetes más recientes si es necesario
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # (Opcional, pero muy común) Home Manager para gestionar la configuración de usuario
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05"; # Usa la versión compatible
      inputs.nixpkgs.follows = "nixpkgs"; # Asegura que use la misma versión de nixpkgs
    };

    # Añadimos Hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs-unstable"; # <-- Hyprland ahora sigue nixpkgs-unstable
    };
  };

  # 2. Salidas (Outputs)
  # Aquí defines lo que tu Flake "produce". En este caso, una configuración de NixOS.
  outputs = { self, nixpkgs, home-manager, hyprland, nixpkgs-unstable, ... }@inputs: {

    # La configuración de tu sistema NixOS
    nixosConfigurations = {
      # ¡¡IMPORTANTE!! Cambia "mi-nixos-pc" por el hostname real de tu máquina.
      # Puedes ver tu hostname con el comando `hostname`.
      thinkcentre = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
         # Tu configuración principal
          ./configuration.nix

         # Módulo de Home Manager
          home-manager.nixosModules.home-manager
        ]; # <--- This closes the modules list
      };
      
      # Puedes añadir más máquinas aquí si gestionas varias
      # otro-pc = nixpkgs.lib.nixosSystem { ... };
    };
  };
}
