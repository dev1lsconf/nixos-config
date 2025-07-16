# /home/dev1ls/nixos-config/modules/services.nix
{ config, pkgs, ... }:

{
  # System Services
  services.printing.enable = true;
  services.flatpak.enable = true;
  services.openssh.enable = true;
  services.tailscale.enable = true;
  services.ollama.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # Virtualisation
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
}
