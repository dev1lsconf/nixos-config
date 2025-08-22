# /home/dev1ls/nixos-config/home.nix
{ config, pkgs, username, configDir, ... }:

let
  cli-pkgs = import "${configDir}/pkgs/pkgs-cli.nix" { inherit pkgs; };
  gui-pkgs = import "${configDir}/pkgs/pkgs-gui.nix" { inherit pkgs; };
  dev-pkgs = import "${configDir}/pkgs/pkgs-dev.nix" { inherit pkgs; };
in
{
  # Home Manager
  home.username = username;
  home.homeDirectory = "/home/${username}";
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
        identityFile = "/home/${username}/.ssh/id_ed25519";
      };
    };
  };

   programs.fish = {
     enable = true;
     shellAbbrs = {
       "g" = "git";
       "god-re" = "doas nixos-rebuild switch --flake .#thinkcentre";
       "god-up" = "nix flake update";
     };
     plugins = with pkgs.fishPlugins; [
       { name = "fzf-fish"; src = fzf-fish; }
       { name = "z"; src = z; }
     ];
   };
  
  programs.firefox.enable = true;

  # --- Declarative Hyprland Config ---
  xdg.configFile = {
    "hypr/hyprland.conf".source = "${configDir}/hypr/hyprland.conf";
    "hypr/keybindings.conf".source = "${configDir}/hypr/keybindings.conf";
    "hypr/windowrules.conf".source = "${configDir}/hypr/windowrules.conf";
  };
}
