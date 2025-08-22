# /home/dev1ls/nixos-config/configuration.nix
# Archivo de configuración principal de NixOS
{ config, pkgs, inputs, lib, username, configDir, ... }:

{
  imports = [
    # Archivos base generados por NixOS
    ./hardware-configuration.nix
  
    # --- Módulos personalizados ---
    ./modules/desktop.nix
    ./modules/services.nix
    ./modules/user.nix
    ./modules/security.nix
  ];

  # 1. Global Settings
  # ============================================================================
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";

  # 2. Bootloader
  # ============================================================================
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable Plymouth
  boot.plymouth = {
    enable = true;
    theme = "rings";
    themePackages = [ pkgs.adi1090x-plymouth-themes ];
  };
 
  # 3. Networking
  # ============================================================================
  networking.hostName = "thinkcentre";
  networking.networkmanager.enable = true; 
  networking.firewall.allowedTCPPorts = [ 6050 18226 2225 19999 ];
  # Reglas específicas para la interfaz ygg0
  networking.firewall.interfaces."ygg0".allowedTCPPorts = [ 6667 80 ];
 
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
   
  # Enable Netdata for system monitoring
  services.netdata = {
    enable = true;
  };

  services.netdata.package = pkgs.netdata.override {
  withCloudUi = true;
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
    extraRules = [{ users = [ username ]; keepEnv = true; persist = true; }];
  };
  security.sudo.enable = false;

  # 8. Gaming Support
  # ============================================================================
  # AÑADIDO: Habilita Steam y sus dependencias.
  programs.steam.enable = true;

  # AÑADIDO: Habilita el soporte para gráficos 32-bit, crucial para Steam y Proton.
  #hardware.opengl.enable = true;
  #hardware.opengl.driSupport32Bit = true;
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  # 9. Home Manager
  # ============================================================================
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  # Pasa la variable 'username' a los módulos de home-manager
  home-manager.users.${username} = import ./home.nix { inherit config pkgs lib inputs username configDir; };
}
