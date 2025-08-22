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
*   **Red P2P Yggdrasil**: Conectividad de red descentralizada y segura.
*   **Monitoreo del Sistema**: Integración con Netdata para una supervisión detallada.
*   **Arranque Gráfico**: Plymouth para una experiencia de arranque visual y personalizable.
*   **Soporte para Juegos**: Habilitación de Steam y soporte de gráficos 32-bit para una amplia compatibilidad.
*   **Monitoreo de Métricas**: Prometheus Node Exporter para la recolección de métricas del sistema.
*   **Versión Fijada**: Anclado a la rama `nixos-25.05` para mayor estabilidad, con acceso a `nixos-unstable` para paquetes específicos como Hyprland.

## 📂 Estructura del Repositorio

La configuración está organizada para ser clara y escalable.

*   `flake.nix`: El corazón de la configuración. Define las dependencias (`nixpkgs`, `home-manager`, `hyprland`, `nixpkgs-unstable`) y expone la configuración del sistema `thinkcentre`.
*   `configuration.nix`: El punto de entrada principal del sistema. Importa todos los demás módulos y establece las configuraciones globales.
*   `home.nix`: Define la configuración del usuario `dev1ls` a través de `home-manager`, importando las listas de paquetes personales y configuraciones de usuario.
*   `hardware-configuration.nix`: Configuración específica del hardware, generada automáticamente.

### Módulos (`modules/`)

La lógica está separada en los siguientes módulos:

*   `desktop.nix`: Configura el entorno gráfico, incluyendo **Hyprland**, XWayland, PipeWire y portales XDG.
*   `security.nix`: Agrupa todas las configuraciones de seguridad: `fail2ban`, `AppArmor`, reglas de firewall y fortalecimiento del kernel.
*   `services.nix`: Gestiona los servicios del sistema como `openssh` (en un puerto no estándar), `endlessh`, `tailscale`, `flatpak`, `podman`, `yggdrasil` y `netdata`.
*   `user.nix`: Define al usuario principal del sistema y sus grupos.

### Configuración de Hyprland (`hypr/`)

Este directorio contiene los archivos de configuración específicos para Hyprland, que son importados por `home.nix` a través de `xdg.configFile`:

*   `hyprland.conf`: Configuración principal de Hyprland.
*   `keybindings.conf`: Definición de atajos de teclado.
*   `windowrules.conf`: Reglas para el comportamiento de las ventanas.

### Paquetes (`pkgs/`)

Los paquetes están categorizados y separados en archivos dentro del directorio `pkgs/` que son importados por `home.nix`:

*   `pkgs-cli.nix`: Software esencial de línea de comandos.
*   `pkgs-gui.nix`: Aplicaciones con interfaz gráfica.
*   `pkgs-dev.nix`: Herramientas de desarrollo.

## 🚀 Uso

Para desplegar esta configuración en la máquina de destino (`thinkcentre`), ejecuta el siguiente comando desde el directorio del repositorio:

```bash
doas nixos-rebuild switch --flake .#thinkcentre
```

### Configuración de Usuario (Home-Manager)

A través de `home-manager`, se gestionan de forma declarativa las configuraciones de usuario, incluyendo:

*   **GitHub CLI (`gh`)**: Configurado para usar SSH.
*   **SSH**: Configuración específica para GitHub.
*   **Fish Shell**: Con alias personalizados (`g`, `god-re`, `god-up`) y plugins (`fzf-fish`, `z`).
*   **Firefox**: Habilitado como navegador predeterminado.

## Nix

Todo el código de configuración de este repositorio está escrito en **Nix**.

