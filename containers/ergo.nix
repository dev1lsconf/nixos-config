{ config, pkgs, ... }:

# Este es un módulo de NixOS.
# Toda la configuración debe estar dentro del atributo 'config'.
{
  config = {
    # Definición del contenedor y su configuración interna
    containers.ergo-irc = {
      autoStart = true;
      privateNetwork = false; # Comparte la red con el host

      # Configuración del sistema operativo que se ejecuta DENTRO del contenedor
      config = {
        system.stateVersion = "25.05";
        services.resolved.enable = true;

        services.ergo = {
          enable = true;
          settings = {
            server = {
              name = "Dnet";
              network-name = "Red Yggdrasil IRC by dev1ls";
            };
            listen = [
              "[200:6823:aabc:7629:cd2d:e9d7:cf7f:c6f8]:6667"
            ];
            accounts = {
              "admin" = {
                password = "surfer02";
                class = "opers";
              };
            };
            log = {
              level = "info";
            };
          };
        };
      };
    };
  };
}
