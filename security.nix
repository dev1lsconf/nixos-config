# /home/dev1ls/nixos-config/security.nix
{ config, pkgs, ... }:

{
  # --- 1. Fortalecimiento del Kernel (Sysctl) ---
  # Estas opciones ajustan parámetros del kernel en tiempo de ejecución para mitigar
  # vulnerabilidades comunes.
  boot.kernel.sysctl = {
    # Previene fugas de direcciones de memoria del kernel.
    "kernel.kptr_restrict" = 2;
    # Deshabilita el uso de BPF por parte de usuarios sin privilegios, una superficie de ataque común.
    "kernel.unprivileged_bpf_disabled" = 1;
    # Activa la protección contra suplantación de IP (IP spoofing).
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;
    # Registra paquetes con direcciones de origen sospechosas.
    "net.ipv4.conf.default.log_martians" = 1;
    "net.ipv4.conf.all.log_martians" = 1;
  };

  # Activa explícitamente la aleatorización del espacio de direcciones (ASLR),
  # una defensa clave contra ataques de corrupción de memoria.
  boot.kernel.features.randomize_va_space.enable = true;


  # --- 2. Cortafuegos (Firewall) Estricto ---
  # Tu cortafuegos ya está activado, pero podemos hacerlo más estricto.
  networking.firewall = {
    enable = true;
    # Rechaza explícitamente las conexiones entrantes en lugar de simplemente ignorarlas (drop).
    # Esto puede dificultar el escaneo de puertos.
    rejectPackets = true;
    # Registra las conexiones rechazadas para su posterior análisis.
    logRefusedConnections = true;
  };


  # --- 3. Control de Acceso Obligatorio (MAC) con AppArmor ---
  # AppArmor confina los programas a un conjunto limitado de recursos, reduciendo
  # el daño que una aplicación vulnerable puede causar.
  security.apparmor = {
    enable = true;
    # Puedes añadir perfiles adicionales aquí si es necesario.
  };


  # --- 5. Seguridad del Sistema de Archivos ---
  # Monta /tmp en RAM (tmpfs) y con opciones de seguridad.
  # Esto asegura que /tmp se limpie en cada reinicio y previene la ejecución de scripts desde él.
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "25%"; # Ajusta el tamaño según tu RAM
}
