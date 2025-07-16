# /home/dev1ls/nixos-config/configuration.nix
# Archivo de configuración principal de NixOS
{ config, pkgs, inputs, ... }:

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
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";

  # 2. Bootloader
  # ============================================================================
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # 3. Networking
  # ============================================================================
  networking.hostName = "thinkcentre";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 9443 9090 ];

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
}
