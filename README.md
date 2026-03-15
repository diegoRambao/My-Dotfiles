# Dotfiles — andres.rambao

Archivos de configuración personal, versionados con git y enlazados con symlinks.

## Estructura

```
dotfiles/
├── .config/
│   ├── nvim/          # Neovim (AstroNvim)
│   ├── fish/          # Fish shell
│   ├── karabiner/     # Karabiner-Elements (remapeo de teclado)
│   └── opencode/      # OpenCode AI (config, tema, tui)
├── .warp/             # Warp terminal (keybindings, temas)
├── zshrc              # Zsh config
├── zprofile           # Zsh profile (env vars tempranas)
├── bashrc             # Bash config
├── bash_profile       # Bash profile
├── gitconfig          # Git config global
├── ideavimrc          # Vim bindings para JetBrains
├── npmrc              # npm config
├── install.sh         # Script de instalación (crea symlinks)
└── README.md          # Este archivo
```

## Instalación en una máquina nueva

```bash
git clone git@github.com:tu-usuario/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

El script crea symlinks desde tu home hacia los archivos del repo.
Si un archivo ya existe y NO es un symlink, se respalda con sufijo `.bak`.

## Uso diario

Cuando editas cualquier archivo de configuración (ej. `~/.zshrc`),
estás editando directamente el archivo dentro del repo gracias al symlink.

Para guardar cambios:

```bash
cd ~/dotfiles
git add -A
git commit -m "descripción del cambio"
git push
```

## Agregar un nuevo archivo

1. Copia el archivo al repo: `cp ~/.nuevo_archivo ~/dotfiles/nuevo_archivo`
2. Agrega la línea de symlink en `install.sh`
3. Ejecuta `./install.sh` para crear el enlace
4. Commit y push

## Agregar un directorio de .config

1. Copia el directorio: `cp -r ~/.config/app ~/dotfiles/.config/app`
2. Agrega la línea en `install.sh` (sección de directorios)
3. Ejecuta `./install.sh`
4. Commit y push
