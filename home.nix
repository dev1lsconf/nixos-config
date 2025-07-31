# /home/dev1ls/nixos-config/home.nix
# SUGERENCIA: Este archivo ahora gestiona toda la configuración de Home Manager.
{ config, pkgs, ... }:

{
  # Configuración de Home Manager para el usuario 'dev1ls'
  home-manager.users.dev1ls = {
    # Importa las listas de paquetes categorizadas
    imports = [
      ./modules/pkgs/pkgs-cli.nix
      ./modules/pkgs/pkgs-gui.nix
      ./modules/pkgs/pkgs-dev.nix
    ];

    # Home Manager necesita un poco de información sobre ti y las rutas que debe gestionar.
    home.username = "dev1ls";
    home.homeDirectory = "/home/dev1ls";

    # Este valor determina la versión de Home Manager con la que tu configuración es compatible.
    home.stateVersion = "25.05";

    # La lista de paquetes ahora está vacía aquí porque se define en los módulos importados.
    # Home Manager combinará automáticamente las listas de los `imports`.
    home.packages = [ ];

    # --- Configuración de Programas ---
    programs.home-manager.enable = true;

    programs.git = {
      enable = true;
      userName = "dev1lsconf";
      userEmail = "dev1lsconf@gmail.com";
    };
    
    programs.gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };

    programs.fish.enable = true;
    
    programs.firefox.enable = true;
  };
}
