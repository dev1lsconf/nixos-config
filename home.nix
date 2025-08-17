# /home/dev1ls/nixos-config/home.nix
{ config, pkgs, ... }:

let
  cli-pkgs = import ./pkgs-cli.nix { inherit pkgs; };
  gui-pkgs = import ./pkgs-gui.nix { inherit pkgs; };
  dev-pkgs = import ./pkgs-dev.nix { inherit pkgs; };
in
{
  # Home Manager necesita un poco de información sobre ti y las rutas que debe gestionar.
  home.username = "dev1ls";
  home.homeDirectory = "/home/dev1ls";
  home.stateVersion = "25.05";

  # Combinamos todas las listas de paquetes en una sola.
  home.packages = cli-pkgs ++ gui-pkgs ++ dev-pkgs;

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
}
