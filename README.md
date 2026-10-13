# DOCUMENTOS ONBOARDING

---

# ❄️ Frost Home

Configuración declarativa del entorno personal utilizando **Nix** y **Home Manager**, diseñada para automatizar la instalación y gestión de paquetes, configuración de dotfiles y personalización del entorno de desarrollo.

## 1. Instalación de Zsh

Si utilizas Ubuntu o Debian, instala **Zsh** ejecutando:

```bash
sudo apt update
sudo apt install -y zsh
```

Verifica la instalación:

```bash
zsh --version
command -v zsh
```

### Establecer Zsh como shell predeterminada

Ejecuta:

```bash
chsh -s "$(command -v zsh)"
```

Cierra la sesión de usuario y vuelve a iniciarla para aplicar el cambio.

Verifica la shell predeterminada:

```bash
echo "$SHELL"
```

El resultado esperado es similar a:

```text
/usr/bin/zsh
```

**Nota:** Si ya utilizas Zsh, puedes omitir este paso.

## 2. Instalación de Nix

Nix es un gestor de paquetes que permite instalar herramientas y mantener configuraciones reproducibles.

### Instalar Nix desde Bash o Zsh

Ejecuta el instalador oficial:

```bash
sh <(curl -L https://nixos.org/nix/install)
```

También puedes utilizar la siguiente alternativa compatible con Bash y Zsh:

```bash
curl -L https://nixos.org/nix/install | sh
```

**Nota:** Después de instalar Nix, cierra y vuelve a abrir la terminal. Si es necesario, reinicia la sesión para cargar las variables de entorno.

### Verificar la instalación

```bash
nix --version
command -v nix
```

Si Nix está instalado correctamente, mostrará su versión y la ruta del ejecutable.

## 3. Instalación de Frost Home con Home Manager

Frost Home utiliza **Home Manager** para administrar declarativamente las herramientas, paquetes y configuraciones del usuario.

### Ejecutar el script de instalación

Desde Bash o Zsh, ejecuta:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/DevFlare2025/frost-home/main/install.sh)"
```

El script se ejecuta con Bash independientemente de la shell utilizada en la terminal.

**Importante:** Revisa el contenido del script antes de ejecutarlo, especialmente si estás configurando un equipo por primera vez.

Puedes consultarlo con:

```bash
curl -fsSL https://raw.githubusercontent.com/DevFlare2025/frost-home/main/install.sh
```

### Verificar Home Manager

Una vez completada la instalación:

```bash
home-manager --version
```

Para verificar que Nix funciona:

```bash
nix --version
```

## 4. Posibles errores y soluciones

### 4.1. Nix no se reconoce como comando

Si aparece:

```text
zsh: command not found: nix
```

Cierra y vuelve a abrir la terminal.

Si Nix está instalado en modo multiusuario y todavía no se encuentra disponible, comprueba si existe el script de inicialización:

```bash
ls -l /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

Si existe, puedes cargarlo en la sesión actual:

```bash
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

Comprueba nuevamente:

```bash
nix --version
```

### 4.2. Visual Studio Code no abre en Ubuntu 24.04

En Ubuntu 24.04, algunas aplicaciones basadas en Electron pueden presentar problemas relacionados con las restricciones de espacios de nombres de usuario de AppArmor.

Si VSCode presenta este problema, puedes revisar los mensajes de error antes de modificar la configuración de seguridad.

Como solución temporal de compatibilidad, puedes utilizar:

```bash
echo "kernel.apparmor_restrict_unprivileged_userns=0" | sudo tee /etc/sysctl.d/60-apparmor-namespace.conf > /dev/null
sudo sysctl --system
```

**Advertencia de seguridad:** Esta configuración reduce las restricciones de seguridad de AppArmor para los espacios de nombres de usuario sin privilegios y afecta al sistema, no solamente a VSCode. Utilízala únicamente cuando sea necesario y después de evaluar alternativas específicas para la aplicación.

Para revertir el cambio:

```bash
sudo rm /etc/sysctl.d/60-apparmor-namespace.conf
sudo sysctl --system
```

### 4.3. Home Manager no se reconoce como comando

Si aparece:

```text
zsh: command not found: home-manager
```

Primero, abre una nueva terminal y verifica que Nix esté disponible:

```bash
nix --version
```

Después, comprueba si Home Manager está instalado y accesible desde el entorno configurado.

## 5. Estructura de archivos

```text
frost-home/
├── home-manager/
│   ├── flake.lock
│   ├── flake.nix
│   └── home.nix
├── install.sh
└── README.md
```

### Descripción de archivos

| Archivo | Descripción |
|---|---|
| `flake.nix` | Define las entradas y configuración reproducible de Nix. |
| `flake.lock` | Mantiene bloqueadas las versiones de las dependencias. |
| `home.nix` | Contiene la configuración declarativa del entorno de usuario. |
| `install.sh` | Script de instalación y configuración inicial. |
| `README.md` | Documentación del proyecto e instrucciones de instalación. |

## 6. Verificación final del entorno

Después de completar la instalación, ejecuta:

```bash
zsh --version
nix --version
home-manager --version
```

Verifica también la shell predeterminada:

```bash
echo "$SHELL"
```

Si los comandos funcionan correctamente, el entorno está listo para utilizar Frost Home.

---

**Frost Home** — Gestión declarativa y reproducible del entorno de desarrollo con Nix y Home Manager.
