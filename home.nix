# /home/dev1ls/nixos-config/home.nix
{ config, pkgs, ... }:

let
  cli-pkgs = import ./pkgs-cli.nix { inherit pkgs; };
  gui-pkgs = import ./pkgs-gui.nix { inherit pkgs; };
  dev-pkgs = import ./pkgs-dev.nix { inherit pkgs; };
in
{
  # Home Manager
  home.username = "dev1ls";
  home.homeDirectory = "/home/dev1ls";
  home.stateVersion = "25.05";

  # listas de paquetes
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

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "/home/dev1ls/.ssh/id_ed25519";
      };
    };
  };

  programs.fish.enable = true;
  
  programs.firefox.enable = true;
}
