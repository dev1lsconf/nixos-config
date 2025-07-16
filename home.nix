# /home/dev1ls/nixos-config/home.nix
{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dev1ls";
  home.homeDirectory = "/home/dev1ls";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "25.05"; # Updated to match nixpkgs 25.05

  # The star of the show: define the packages you want to install.
  home.packages = []; # All packages moved to modules/user.nix

   # Basic configuration for git
  programs.git = {
    enable = true;
    userName = "dev1ls";
    userEmail = "dev1ls@sdf.org"; # Cambia esto a tu email
  };

  # Nicer feeling shell
  programs.fish.enable = true;
  
}
