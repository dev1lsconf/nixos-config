# /home/dev1ls/nixos-config/modules/user.nix
# SUGERENCIA: Este archivo ahora solo define al usuario a nivel de sistema.
# La configuración de Home Manager se ha movido a /home/dev1ls/nixos-config/home.nix
{ config, pkgs, lib, ... }:

{
  # Define el usuario 'dev1ls' en el sistema.
  users.users.dev1ls = {
    isNormalUser = true;
    description = "dev1ls";
    # Asegúrate de que los grupos son correctos para tus necesidades.
    extraGroups = [ "networkmanager" "wheel" "docker" "podman" ];
  };
}
