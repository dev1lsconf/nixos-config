# /home/dev1ls/honeypot.nix
# Módulo para configurar el honeypot Dionaea.
{ config, pkgs, ... }:

{
  services.dionaea = {
    enable = true;
    # Escucha en todas las interfaces de red (0.0.0.0)
    interfaces = [ "all" ];
  };

  # Dionaea emula varios servicios. Asegúrate de que los puertos
  # que quieres exponer estén abiertos en el firewall.
  # Estos son los puertos por defecto de Dionaea.
  networking.firewall.allowedTCPPorts = [
    21   # FTP
    80   # HTTP
    135  # MS-RPC
    443  # HTTPS
    445  # SMB
    1433 # MSSQL
  ];
  networking.firewall.allowedUDPPorts = [
    69   # TFTP
    1434 # MSSQL
  ];
}
