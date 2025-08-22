# /home/dev1ls/nixos-config/modules/pkgs/pkgs-gui.nix
# Paquetes de la interfaz gráfica de usuario (GUI)
{ pkgs, ... }:

with pkgs; [
  # --- Emuladores de Terminal ---
  alacritty
  kitty
  sakura
  st
  ghostty

  # --- Entorno de Escritorio y Utilidades ---
  i3
  polybar
  rofi
  picom
  nitrogen
  cava
  lxappearance
  pavucontrol
  waybar
  wlogout
  hyprpaper
  swww
  grim
  slurp
  wf-recorder
  neofetch # 

  # --- Navegadores y Aplicaciones de Internet ---
  brave
  google-chrome
  surf

  # --- Multimedia ---
  spotify
  mpv
  stremio
  nsxiv
  ffmpeg
  yt-dlp
  gnome-screenshot
  shutter
  
  # --- Gestores de Archivos ---
  pcmanfm
  nautilus

  # --- Utilidades del Sistema (GUI) ---
  gparted
  unetbootin
  blueman
  transmission_4 # Asumiendo cliente GUI

  # --- Juegos ---
  lutris

  # --- Contenedores (GUI) ---
  podman-desktop
]
