# dev1ls' NixOS Configuration

![My NixOS Configuration Hyprland + NixOS](mynixos.png "Hyprland + NixOS")

Esta es mi configuración personal y declarativa de NixOS, gestionada a través de **Nix Flakes** para garantizar la máxima reproducibilidad y consistencia.

## ✨ Características Principales

*   **Gestión con Flakes**: Todo el sistema es una `flake`, lo que permite una gestión de dependencias hermética y builds 100% reproducibles.
*   **Altamente Modular**: La configuración está dividida en módulos lógicos (`desktop`, `security`, `services`, etc.) y listas de paquetes separadas, facilitando el mantenimiento.
*   **Entorno de Escritorio Moderno**: Utiliza **Hyprland** como compositor principal sobre Wayland, con PipeWire para la gestión de audio.
*   **Gestión de Usuario con Home-Manager**: Los `dotfiles` y paquetes de usuario se gestionan de forma declarativa a través de `home-manager`.
*   **Seguridad Reforzada**: Implementa varias capas de seguridad, incluyendo un cortafuegos estricto, `fail2ban`, `AppArmor` y configuraciones de fortalecimiento del kernel.
*   **Soporte para Contenedores**: Integración nativa de **Podman** y **Docker**.
*   **Versión Fijada**: Anclado a la rama `nixos-25.05` para mayor estabilidad, con acceso a `nixos-unstable` para paquetes específicos como Hyprland.

## 📂 Estructura del Repositorio

La configuración está organizada para ser clara y escalable.

*   `flake.nix`: El corazón de la configuración. Define las dependencias (`nixpkgs`, `home-manager`, `hyprland`) y expone la configuración del sistema `thinkcentre`.
*   `configuration.nix`: El punto de entrada principal del sistema. Importa todos los demás módulos y establece las configuraciones globales.
*   `home.nix`: Define la configuración del usuario `dev1ls` a través de `home-manager`, importando las listas de paquetes personales.
*   `hardware-configuration.nix`: Configuración específica del hardware, generada automáticamente.

### Módulos (`modules/`)

La lógica está separada en los siguientes módulos:

*   `desktop.nix`: Configura el entorno gráfico, incluyendo **Hyprland**, XWayland, PipeWire y portales XDG.
*   `security.nix`: Agrupa todas las configuraciones de seguridad: `fail2ban`, `AppArmor`, reglas de firewall y fortalecimiento del kernel.
*   `services.nix`: Gestiona los servicios del sistema como `openssh` (en un puerto no estándar), `endlessh`, `tailscale`, `flatpak` y `podman`.
*   `user.nix`: Define al usuario principal del sistema y sus grupos.

### Paquetes (`pkgs-*.nix`)

Los paquetes están categorizados y separados en archivos que son importados por `home.nix`:

*   `pkgs-cli.nix`: Software esencial de línea de comandos.
*   `pkgs-gui.nix`: Aplicaciones con interfaz gráfica.
*   `pkgs-dev.nix`: Herramientas de desarrollo.

## 🚀 Uso

Para desplegar esta configuración en la máquina de destino (`thinkcentre`), ejecuta el siguiente comando desde el directorio del repositorio:

```bash
doas nixos-rebuild switch --flake .#thinkcentre
```

## Nix

Todo el código de configuración de este repositorio está escrito en **Nix**.

