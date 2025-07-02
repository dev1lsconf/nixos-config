# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "thinkcentre"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Pantheon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.pantheon.enable = true;
  services.xserver.windowManager.i3.enable = true; 
  services.xserver.windowManager.cwm.enable = true;

   # Configure keymap in X11
  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "es";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dev1ls = {
    isNormalUser = true;
    description = "dev1ls";
    extraGroups = [ "networkmanager" "wheel" "docker" "podman" ];
    packages = with pkgs; [
    #  thunderbird
       neovim
       vim
       fzf
       fish
       tmux
       nodejs
       fd
       twtxt
       mosh
       nitrogen
       brave
       google-chrome
       spotify
       mpv
       ripgrep
       alacritty
       sakura
       unzip
       kitty
       tut
       toot
       stremio
       pcmanfm
       nautilus
       castero
       nsxiv
       unrar
       curl
       wget
       claude-code
       ghostty
       ranger
       glances
       python313Packages.textual
       mpv
       htop
       python311
       python3
       git
       st
       gcc
       gotop
       podman-tui
       glances
       bluetui
       duf
       ncdu
       lazydocker
       cloudflared
       gparted
       cloudflare-cli
       cloudflare-warp     
       lxappearance
       podman-compose
       rofi
       reddit-tui
       unetbootin
       nautilus
       cava
       polybar
       i3-gaps
       picom 
       neofetch  
       gtk3 
       tty-clock
       powerline
       profanity
       bombadillo
       amfora
       lynx
       bmon
       gh
       pavucontrol
       shutter
       pipx
       surf
       yt-dlp
       invidtui
       newsboat
       ffmpeg
       gnome-screenshot
       (python3.withPackages (ps: with ps; [
         requests
         pandas
	 textual
       ]))

    ];
  };

   # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
   
  # Flatpack
  services.flatpak.enable = true;

  # Docker
  virtualisation.docker.enable = true;
  
  #tailscale
  services.tailscale.enable = true;

  programs.dconf.enable = true;
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];
  
  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [{
  users = ["dev1ls"];
  # Optional, retains environment variables while running commands 
  # e.g. retains your NIX_PATH when applying your config
  keepEnv = true; 
  persist = true;  # Optional, only require password verification a single time
  }];

  
  services.ollama = {
    enable = true;
      # Optional: preload models, see https://ollama.com/library
        loadModels = [ "llama3.2:3b" "deepseek-r1:1.5b"];
	};

  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
        enable = true;
  # Create a `docker` alias for podman, to use it as a drop-in replacement
  dockerCompat = false;
  # Required for containers under podman-compose to be able to talk to each other.
  defaultNetwork.settings.dns_enabled = true;
  };
  };

		
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 80 9443 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
