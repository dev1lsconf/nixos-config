# /home/dev1ls/nixos-config/overlays.nix
self: super: {
  cockpit-podman = super.callPackage ./packages/cockpit/podman-containers.nix { };
}
