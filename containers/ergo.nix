{
  # Este archivo define un contenedor de NixOS llamado 'ergo-irc'

  # Opciones para el propio contenedor
  containers.ergo-irc = {
    autoStart = true;
    privateNetwork = false; # Comparte la red con el host
  };

  # Configuración del sistema operativo que se ejecuta DENTRO del contenedor
  # Esta es la forma canónica de asignar configuración a un contenedor desde un módulo.
  config.containers.ergo-irc.config = {
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
}
