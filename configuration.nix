# /home/dev1ls/nixos-config/configuration.nix
# Modificado para añadir Hyprland

{ config, pkgs, inputs, ... }: # Se añade 'inputs' para poder usar el flake de Hyprland opcionalmente

{
  imports = [
    ./hardware-configuration.nix
  ];

  # 1. Global Settings
  # ============================================================================
  nixpkgs.overlays = [ (import ./overlays.nix) ];
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05"; # System's state version

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

  # 5. Graphics & Audio
  # ============================================================================ 
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-sdk # For older Intel GPUs
    ];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # 6. GUI & Windowing System (Modificado para Hyprland)
  # ============================================================================
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true; # lightdm funciona bien con Hyprland
    #desktopManager.pantheon.enable = true; # Deshabilitado para evitar conflictos con Hyprland
    windowManager.i3.enable = true;      # Puedes mantener i3
    windowManager.cwm.enable = true;     # y cwm como opciones en lightdm
    xkb = { layout = "es"; variant = ""; };
  };
  console.keyMap = "es";
  programs.dconf.enable = true;

  # Habilitamos Hyprland y Wayland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # Opcional: si quieres usar la versión de Hyprland del flake en lugar de la de nixpkgs
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  # Portales XDG para Wayland (Hyprland) y GTK
  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk 
      pkgs.xdg-desktop-portal-hyprland # Específico para Hyprland
    ];
  };

  # 7. System Services
  # ============================================================================
  services.printing.enable = true;
  services.flatpak.enable = true;
  services.openssh.enable = true;
  services.tailscale.enable = true;
  services.ollama.enable = true;
  services.cockpit.enable = true;

  # 8. Virtualisation
  # ============================================================================
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  
  # 9. Security
  # ============================================================================
  security.doas = {
    enable = true;
    extraRules = [{ users = [ "dev1ls" ]; keepEnv = true; persist = true; }];
  };
  security.sudo.enable = false;

  # 10. System-wide Packages (Añadidos paquetes para Hyprland)
  # ============================================================================
  environment.systemPackages = with pkgs; [ 
    # Originales
    wget 
    neovim 
    git # Añadido para que Flakes funcione correctamente

    # Esenciales para Hyprland
    rofi-wayland  # Lanzador de aplicaciones para Wayland
    waybar        # Barra de estado
    mako          # Demonio de notificaciones
    hyprpaper     # Gestor de fondos de pantalla
    wl-clipboard  # Utilidades de portapapeles para Wayland
    cliphist      # Historial del portapapeles
    (pkgs.cockpit-podman)
  ];

  # 11. User Definition and Home Manager Configuration
  # ============================================================================
  users.users.dev1ls = {
    isNormalUser = true;
    description = "dev1ls";
    extraGroups = [ "networkmanager" "wheel" "docker" "podman" ];
  };

  home-manager.backupFileExtension = "backup";
  home-manager.users.dev1ls = {
    # This must match the version of Home Manager you are using in your flake.nix
    home.stateVersion = "24.05";
    
    home.enableNixpkgsReleaseCheck = false;

    home.packages = with pkgs; [
      # --- CLI Tools ---
      fish
      tmux
      alacritty
      kitty
      sakura
      st
      powerline
      tty-clock
      neovim
      vim
      git
      gcc
      fzf
      nodejs
      fd
      ripgrep
      curl
      unzip
      unrar
      pipx
      (python3.withPackages (ps: with ps; [ requests pandas textual ]))
      glances
      htop
      gotop
      duf
      ncdu
      gparted
      bluetui
      ranger
      pcmanfm
      nautilus
      gemini-cli
      twtxt
      mosh
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
      gh
      emoji-picker
      translate-shell
      alsa-utils
      pamixer
      ncpamixer
      gcc
      gnumake 
      pkg-config 
      curl 
      json_c
      libgnurl
      inih

      # --- GUI Apps ---
      brave
      google-chrome
      spotify
      mpv
      stremio
      nsxiv
      ffmpeg
      yt-dlp
      gnome-screenshot
      shutter
      i3
      polybar
      rofi
      picom
      neofetch
      nitrogen
      cava
      lxappearance
      pavucontrol
      cloudflared
      cloudflare-cli
      podman-tui
      podman-compose
      lazydocker
      unetbootin
      ghostty
      podman-desktop
      zenith
    ];

    # --- Program Configuration ---
    programs.firefox.enable = true;
    programs.git.enable = true;
    programs.fish.enable = true;
  };
}
