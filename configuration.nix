# /home/dev1ls/nixos-config/configuration.nix
# Archivo de configuración principal de NixOS
# COPIA MODIFICADA con Steam y Proton
{ config, pkgs, inputs, lib, ... }:

# Crear una referencia explícita al conjunto de paquetes principal para evitar problemas de alcance.
let
  mainPkgs = pkgs;
in
{
  imports = [
    # Archivos base generados por NixOS
    ./hardware-configuration.nix
    ./security.nix

    # --- Módulos personalizados ---
    ./modules/desktop.nix
    ./modules/services.nix
    ./modules/user.nix
  ];

  

  

  # 1. Global Settings
  # ============================================================================
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-run"
    "spotify"
    "brave"
    "google-chrome"
    "unrar"
    "stremio-shell"
    "stremio-server"
    "steam-unwrapped"
    "vscodium"
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";

  # 2. Bootloader
  # ============================================================================
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" =80;

  # 3. Networking
  # ============================================================================
  networking.hostName = "thinkcentre";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 6050 18226 2225 ];
  # Reglas específicas para la interfaz ygg0
  networking.firewall.interfaces."ygg0".allowedTCPPorts = [ 6667 ];

  #networking.firewall.extraCommands = ''
  #  iptables -A nixos-fw -i ygg0 -p tcp --dport 6667 -j ACCEPT
  #  iptables -A nixos-fw -i ygg0 -p tcp --dport 6697 -j ACCEPT
  #'';
  #networking.firewall.extraStopCommands = ''
  #  iptables -D nixos-fw -i ygg0 -p tcp --dport 6667 -j ACCEPT
  #  iptables -D nixos-fw -i ygg0 -p tcp --dport 6697 -j ACCEPT
  #'';
 
  services.yggdrasil = {
  enable = true;
  persistentKeys = true; # Store keys in /var/lib/yggdrasil/private.key
  settings = {
    Peers = [
      "tls://spain.magicum.net:36901"
      "tcp://rendezvous.anton.molyboha.me:50421"
      "quic://vix.duckdns.org:36014"
      "tls://vix.duckdns.org:36014"
      "quic://spain.magicum.net:36900"
      # Add more peers from https://github.com/yggdrasil-network/public-peers
    ];
    IfName = "ygg0";
    NodeInfo = {
      name = "dev1ls.thinkcentre";
      };
      ZoneInfo = {
        "dev1ls.ygg" = {
          "A" = [ "200:6823:aabc:7629:cd2d:e9d7:cf7f:c6f8" ]; # Reemplaza con tu dirección IPv6 de Yggdrasil
          "TXT" = [ "Servicio web en Yggdrasil - dev1ls homepage" ];
        };
      };
    };
  };
   
  # Enable Bluetooth
  hardware.bluetooth.enable = true;

  # 4. Internationalisation & Time
  # ============================================================================
  time.timeZone = "Europe/Madrid";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # 5. System-wide Packages
  # ============================================================================
  environment.systemPackages = with pkgs; [
    git # Added git for system-wide availability
    prometheus-node-exporter
  ];

  # 6. System Maintenance (Paso 4)
  # ============================================================================
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.settings.auto-optimise-store = true;

  # 7. Security
  # ============================================================================
  security.doas = {
    enable = true;
    extraRules = [{ users = [ "dev1ls" ]; keepEnv = true; persist = true; }];
  };
  security.sudo.enable = false;

  # 8. Gaming Support
  # ============================================================================
  # AÑADIDO: Habilita Steam y sus dependencias de forma idiomática.
  programs.steam.enable = true;

  # AÑADIDO: Habilita el soporte para gráficos 32-bit, crucial para Steam y Proton.
  #hardware.opengl.enable = true;
  #hardware.opengl.driSupport32Bit = true;
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
}
