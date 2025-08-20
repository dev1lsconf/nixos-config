# /home/dev1ls/nixos-config/modules/user.nix
# SUGERENCIA: Este archivo ahora solo define al usuario a nivel de sistema.
# La configuración de Home Manager se ha movido a /home/dev1ls/nixos-config/home.nix
{ config, pkgs, lib, username, ... }:

{
  # Define el usuario en el sistema usando la variable de flake.nix.
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    # Asegúrate de que los grupos son correctos para tus necesidades.
    extraGroups = [ "networkmanager" "wheel" "docker" "podman" ];
  };
}
