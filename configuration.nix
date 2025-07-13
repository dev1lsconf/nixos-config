# /home/dev1ls/nixos-config/configuration.nix
# Expertly Refactored by Your AI Assistant (Final Portal Implementation Fix)

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # 1. Global Settings
  # ============================================================================
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
  networking.firewall.allowedTCPPorts = [ 22 80 9443 ];

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

  # 6. GUI & Windowing System
  # ============================================================================
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.pantheon.enable = true;
    windowManager.i3.enable = true;
    windowManager.cwm.enable = true;
    xkb = { layout = "es"; variant = ""; };
  };
  console.keyMap = "es";
  programs.dconf.enable = true;
  # XDG Desktop Portals are required for Flatpak and other sandboxed applications.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # 7. System Services
  # ============================================================================
  services.printing.enable = true;
  services.flatpak.enable = true;
  services.openssh.enable = true;
  services.tailscale.enable = true;
  services.ollama.enable = true;

  # 8. Virtualisation
  # ============================================================================
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  services.cockpit = {
  enable = true;
  port = 9090;
  # openFirewall = true; # Please see the comments section
  settings = {
    WebService = {
      AllowUnencrypted = true;
    };
  };
};

  # 9. Security
  # ============================================================================
  security.doas = {
    enable = true;
    extraRules = [{ users = [ "dev1ls" ]; keepEnv = true; persist = true; }];
  };
  security.sudo.enable = false;

  # 10. System-wide Packages
  # ============================================================================
  environment.systemPackages = with pkgs; [ wget cockpit ];

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
    ];

    # --- Program Configuration ---
    programs.firefox.enable = true;
    programs.git.enable = true;
    programs.fish.enable = true;
  };
}
