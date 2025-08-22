# /home/dev1ls/nixos-config/modules/desktop.nix
{ config, pkgs, inputs, ... }:

{
  # GUI & Windowing System
  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];
    displayManager.gdm.enable = true;  
    windowManager.i3.enable = true;
    windowManager.cwm.enable = true;
    xkb = { layout = "es"; variant = ""; };
  };
  console.keyMap = "es";
  programs.dconf.enable = true;

  # Hyprland & Wayland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = pkgs.unstable.hyprland;
  };

  # XDG Portals
  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk 
    ];
  };

  # Graphics & Audio
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-sdk
    ];
  };
  

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
