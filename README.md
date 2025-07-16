# dev1lsconf/nixos-config

![My NixOS Configuration Hyprland + NixOS](mynixos.png "Hyprland + NixOS")


Esta es mi **configuración personal de NixOS** [1-3].

## Versión de NixOS

Esta configuración está diseñada para ser utilizada con **NixOS versión 25.05**. [Tenga en cuenta que la especificación de la versión 25.05 de NixOS proviene de su consulta y no se encuentra explícitamente en las fuentes proporcionadas.]

## Uso de Nix Flakes

Esta configuración de NixOS aprovecha las **Nix Flakes** para una gestión de dependencias y una reproducibilidad mejoradas. La estructura del repositorio incluye archivos clave como `flake.nix` y `flake.lock` [2], que son fundamentales para este enfoque basado en Flakes. Esto permite una forma más estructurada y reproducible de construir y desplegar el sistema.

## Configuración Modular

El diseño de esta configuración de NixOS es **altamente modular** [2], lo que facilita su mantenimiento, comprensión y extensión. La configuración se organiza en una serie de archivos `.nix` dedicados, así como en un directorio `modules/` [2] para componentes personalizados. Este enfoque modular garantiza que las diferentes partes de la configuración se puedan gestionar de forma independiente y se reutilicen fácilmente.

Los componentes clave de esta configuración modular incluyen:

*   **`modules/`**: Este directorio contiene **módulos de configuración personalizados** [2], lo que permite agrupar lógicamente configuraciones específicas o funcionalidades adicionales.
*   **`configuration.nix`**: El **archivo principal de configuración del sistema** NixOS [2], que orquesta la inclusión de los demás módulos.
*   **`home.nix`**: Dedicado a la **configuración a nivel de usuario** [2], gestionando aspectos como los programas instalados por el usuario y sus configuraciones de `dotfiles`.
*   **`hardware-configuration.nix`**: Contiene la **configuración específica del hardware** [2] de la máquina, como las definiciones de discos y interfaces de red.
*   **`security.nix`**: Un archivo específico para la **configuración de aspectos de seguridad** del sistema [2].

Esta estructura contribuye a una configuración de sistema organizada y clara.

## Idioma

Todo el código de configuración de este repositorio está escrito en **Nix**, constituyendo el 100% de los lenguajes de programación utilizados [3].
