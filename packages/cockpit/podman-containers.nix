# /home/dev1ls/nixos-config/packages/cockpit/podman-containers.nix
{ lib, stdenv, fetchzip, gettext }:

stdenv.mkDerivation rec {
  pname = "cockpit-podman";
  version = "104";

  src = fetchzip {
    url = "https://github.com/cockpit-project/cockpit-podman/releases/download/104/cockpit-podman-104.tar.xz";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Placeholder
  };

  nativeBuildInputs = [
    gettext
  ];

  makeFlags = [ "PREFIX=${placeholder "out"}" ];
}
