# /home/dev1ls/nixos-config/modules/services.nix
{ config, pkgs, ... }:

{
  # System Services
  #services.printing.enable = true;
  services.flatpak.enable = true; 
  #services.openssh.enable = true;
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    # settings.PasswordAuthentication = false;
    # settings.KbdInteractiveAuthentication = false
    settings.PermitRootLogin = "no";
  };

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
