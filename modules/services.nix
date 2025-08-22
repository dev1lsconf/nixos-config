# /home/dev1ls/nixos-config/modules/services.nix
{ config, pkgs, ... }:

{
  # System Services
  #services.printing.enable = true;
  services.flatpak.enable = true; 
  
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    # settings.PasswordAuthentication = false;
    # settings.KbdInteractiveAuthentication = false
    settings.PermitRootLogin = "no";
  };
  
     
  # Configura el honeypot en el puerto estándar SSH
  services.openssh.ports = [ 2225 ];
 
  services.endlessh = {
       enable = true;
       port = 22; # Puerto donde Endlessh escuchará
     };
  

  services.tailscale.enable = true;
  services.ollama.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.upower.enable = true;
  
  
  # Virtualisation
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  
  # Reverse Proxy for Yggdrasil Web Service
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    # Proxy for the ygg-web-custom container
    virtualHosts."yggdrasil-web" = {
      listen = [
        { addr = "[::]"; port = 80; }
      ];
      
      locations."/" = {
        proxyPass = "http://127.0.0.1:8080";
      };
    };
  };

  # Systemd dependency to ensure Nginx starts after Yggdrasil is ready
  systemd.services.nginx = {
    after = [ "yggdrasil.service" ];
    wantedBy = [ "multi-user.target" ];
  };

}
