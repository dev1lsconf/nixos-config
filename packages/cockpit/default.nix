# /home/dev1ls/nixos-config/packages/cockpit/default.nix
{ pkgs, ... }:

{
  podman-containers = pkgs.callPackage ./podman-containers.nix { };
}
