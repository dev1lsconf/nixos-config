# /home/dev1ls/nixos-config/modules/user.nix
{ config, pkgs, lib, ... }: # Added 'lib' to arguments

{
  # User Definition
  users.users.dev1ls = {
    isNormalUser = true;
    description = "dev1ls";
    extraGroups = [ "networkmanager" "wheel" "docker" "podman" ];
  };

  # Home Manager Configuration
  home-manager.backupFileExtension = "backup";
  home-manager.users.dev1ls = {
    home.stateVersion = "25.05";
    home.enableNixpkgsReleaseCheck = false;

    # Explicitly prevent Home Manager from creating the service file
    #xdg.configFile."systemd/user/xdg-desktop-portal-hyprland.service".source = lib.mkForce null;

    home.packages = with pkgs; [
      # --- CLI Tools ---
      fish tmux alacritty kitty sakura st powerline tty-clock neovim vim
      git gcc fzf nodejs fd ripgrep curl unzip unrar pipx
      (python3.withPackages (ps: with ps; [ requests pandas textual ]))
      glances htop gotop duf ncdu gparted bluetui ranger pcmanfm
      nautilus gemini-cli twtxt mosh tut toot castero invidtui
      newsboat reddit-tui profanity bombadillo amfora lynx bmon
      emoji-picker translate-shell alsa-utils pamixer ncpamixer gnumake
      pkg-config json_c libgnurl inih hyprpaper swww grim slurp wf-recorder

      # --- GUI Apps ---
      brave google-chrome spotify mpv stremio nsxiv ffmpeg yt-dlp
      gnome-screenshot shutter i3 polybar rofi picom neofetch
      nitrogen cava lxappearance pavucontrol cloudflared
      cloudflare-cli podman-tui podman-compose lazydocker unetbootin

      ghostty podman-desktop zenith waybar wl-clipboard wlogout spotify
    ];

    # --- Program Configuration ---
    programs.firefox.enable = true;
    programs.git.enable = true;
    programs.gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };
    programs.fish.enable = true;
  };
}
