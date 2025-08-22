# /home/dev1ls/nixos-config/modules/pkgs/pkgs-dev.nix
# Paquetes para desarrollo de software
{ pkgs, ... }:

with pkgs; [
  # --- Control de Versiones ---
  git

  # --- Compiladores y Toolchains ---
  gcc
  gnumake
  pkg-config

  # --- Ecosistema Python ---
  (python3.withPackages (ps: with ps; [
    requests
    pandas
    textual
    irc
  ]))

  # --- Ecosistema JavaScript ---
  nodejs

  # --- Bibliotecas y Utilidades ---
  json_c
  libgnurl
  inih
]
