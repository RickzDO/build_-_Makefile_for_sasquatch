#!/bin/bash

if [ $UID -eq 0 ]; then
    SUDO=""
else
    SUDO="sudo"
fi

# Instalar dependencias
if hash apt-get &>/dev/null; then
    $SUDO apt-get install -y build-essential liblzma-dev liblzo2-dev zlib1g-dev
fi

# Establecer ruta base absoluta del script
BASE_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"

# Cambiar al directorio squashfs4.3
cd "$BASE_DIR/../squashfs4.3"

# Aplicar el parche
patch -p0 < "$BASE_DIR/../patches/patch0.txt"

# Compilar en squashfs-tools
cd squashfs-tools
make && $SUDO make install
