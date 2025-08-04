# **DOCUMENTOS ONBOARDING**
---
# ❄️ Frost Home

Configuración declarativa del entorno personal usando **Nix** y **Home Manager**, pensada para automatizar la instalación y gestión de paquetes, configuración de dotfiles, y personalización del entorno de desarrollo.

## 1. Instalación de la herramienta Nix

Instala Nix ejecutando este comando en tu terminal:

```bash
sh <(curl -L https://nixos.org/nix/install)
```
NOTE: Después de instalar, reinicia tu computadora o cierra y vuelve a abrir la terminal para que los cambios surtan efecto.
verificar la instalación con:

```bash
nix --version
which nix
```
## 2. Script de instalación de Home Manager

Ejecuta el siguiente comando para aplicar esta configuración de frost-home:
 ```bash
bash -c "$(curl -sL https://raw.githubusercontent.com/DevFlare2025/frost-home/main/install.sh)"
```
 Posibles errores
VSCode no abre en Ubuntu 24.04

En caso de que tengas problemas al ejecutar VSCode con errores relacionados a AppArmor, puedes corregirlo con:
```bash
echo "kernel.apparmor_restrict_unprivileged_userns=0" | sudo tee /etc/sysctl.d/60-apparmor-namespace.conf > /dev/null
sudo sysctl --system
```
## 3. Estructura de archivos
```bash
frost-home/
├── home-manager/
│   ├── flake.lock
│   ├── flake.nix
│   └── home.nix
├── install.sh
└── README.md
```
