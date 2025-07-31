# /home/dev1ls/nixos-config/modules/pkgs/pkgs-cli.nix
# Paquetes de la interfaz de línea de comandos (CLI)
{ pkgs, ... }:

with pkgs; [
  # --- Shells & Terminal ---
  fish
  tmux
  powerline
  tty-clock
  neovim
  vim
  irssi
  screenfetch

  # --- Utilidades de Archivos y Búsqueda ---
  fzf
  fd
  ripgrep
  ranger
  unzip
  unrar
  duf
  ncdu

  # --- Redes y Conectividad ---
  curl
  mosh
  inetutils
  dnsutils
  netscanner
  bandwhich
  cloudflared
  ipscan
  cloudflare-cli

  # --- Herramientas del Sistema y Monitorización ---
  glances
  htop
  gotop
  bluetui
  alsa-utils
  pamixer
  ncpamixer
  wl-clipboard
  zenith

  # --- Clientes de Servicios y Redes Sociales ---
  gemini-cli
  twtxt
  tut
  toot
  castero
  invidtui
  newsboat
  reddit-tui
  profanity
  bombadillo
  amfora
  lynx
  bmon
  weechat

  # --- Otras Utilidades ---
  emoji-picker
  translate-shell
  glow
  pipx
  
  # --- Contenedores (CLI) ---
  podman-tui
  podman-compose
  lazydocker
]
