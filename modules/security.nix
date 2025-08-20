# /home/dev1ls/security.nix
{ config, pkgs, ... }:

{
  # --- 1. Fortalecimiento del Kernel (Sysctl) ---
  boot.kernel.sysctl = {
    "kernel.kptr_restrict" = 2;
    "kernel.unprivileged_bpf_disabled" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.default.log_martians" = 1;
    "net.ipv4.conf.all.log_martians" = 1;
  };
  boot.kernel.features.randomize_va_space.enable = true;
  #boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" =80;

  # --- 2. Cortafuegos (Firewall) Estricto ---
  networking.firewall = {
    enable = true;
    rejectPackets = true;
    logRefusedConnections = true;
  };

  # --- 3. Control de Acceso Obligatorio (MAC) con AppArmor ---
  security.apparmor = {
    enable = true;
  };

  # --- 4. Fail2ban (SOLUCIÓN CORRECTA Y DEFINITIVA) ---
  # Servicio de protección contra ataques de fuerza bruta.
  services.fail2ban = {
    enable = true;
    ignoreIP = [ "127.0.0.1" "::1" ];
    # Definimos la cárcel 'sshd' con la estructura correcta para que se fusione
    # con la configuración automática del módulo openssh.
    jails.sshd = {
      enabled = true;
      # Los parámetros específicos van dentro del sub-atributo 'settings'.
      settings = {
        port = 2225;
        maxretry = 3;
      };
    };
  };

  # --- 5. Seguridad del Sistema de Archivos ---
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "25%";
}
