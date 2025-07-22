# /home/dev1ls/security.nix
# COPIA MODIFICADA con Fail2ban
{ config, pkgs, ... }:

{
  # --- 1. Fortalecimiento del Kernel (Sysctl) ---
  # (Tu configuración existente se mantiene aquí)
  boot.kernel.sysctl = {
    "kernel.kptr_restrict" = 2;
    "kernel.unprivileged_bpf_disabled" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.default.log_martians" = 1;
    "net.ipv4.conf.all.log_martians" = 1;
  };
  boot.kernel.features.randomize_va_space.enable = true;

  # --- 2. Cortafuegos (Firewall) Estricto ---
  # (Tu configuración existente se mantiene aquí)
  networking.firewall = {
    enable = true;
    rejectPackets = true;
    logRefusedConnections = true;
  };

  # --- 3. Control de Acceso Obligatorio (MAC) con AppArmor ---
  # (Tu configuración existente se mantiene aquí)
  security.apparmor = {
    enable = true;
  };

  # --- 4. Fail2ban (NUEVA SECCIÓN) ---
  # Servicio de protección contra ataques de fuerza bruta.
  services.fail2ban = {
    enable = true;
    # IPs a ignorar. Es CRUCIAL añadir localhost y, si tienes, tu IP estática local.
    ignoreIP = [ "127.0.0.1" "::1" ];
    # Cárceles (Jails) para servicios específicos.
    jails = {
      # Nombre de la cárcel, debe coincidir con un filtro existente.
      "sshd" = ''
        enabled = true
        # ¡IMPORTANTE! Especificamos el puerto personalizado de tu SSH.
        port = 2225
        # Filtro a usar (ya viene predefinido en Fail2ban).
        filter = sshd
        # Archivo de log a monitorizar. NixOS lo configura automáticamente.
        logpath = /var/log/auth.log
        # Número de reintentos antes de banear.
        maxretry = 3
        # Tiempo de baneo en segundos (1 hora).
        bantime = 3600
      '';
    };
  };

  # --- 5. Seguridad del Sistema de Archivos ---
  # (Tu configuración existente se mantiene aquí)
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "25%";
}
