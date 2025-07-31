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

  # --- 4. Fail2ban (CORREGIDO) ---
  # Servicio de protección contra ataques de fuerza bruta.
  services.fail2ban = {
    enable = true;
    # IPs a ignorar. Es CRUCIAL añadir localhost y, si tienes, tu IP estática local.
    ignoreIP = [ "127.0.0.1" "::1" ];
   };

  # --- 5. Seguridad del Sistema de Archivos ---
  # (Tu configuración existente se mantiene aquí)
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "25%";
}
