#!/bin/sh

# MQ install script
# (c) 2024 Nakidai

string_contain() { case $2 in *$1* ) return 0;; *) return 1;; esac ;}

DEFAULT_SL_PATH="/home/$(logname)/.local/share/Steam/steamapps/"
DEFAULT_MQ_VER="1_1"
VERSIONS="1 1_1"

printf "Enter path to steamapps ($DEFAULT_SL_PATH): "
read slpath
slpath=${slpath:-"$DEFAULT_SL_PATH"}
if ! [ -d "$slpath" ]; then
    echo "Folder \"$slpath\" doesn't exist!"
    exit 1
fi

printf "Enter MQ version (available: $VERSIONS) ($DEFAULT_MQ_VER): "
read mqver
mqver=${mqver:-"$DEFAULT_MQ_VER"}

bppath="MQr$mqver"

echo "Downloading..."
mkdir -p "$slpath/workshop/387990/$bppath"
if ! wget -O "$slpath/workshop/387990/$bppath/blueprint.json" "https://github.com/UltraQbik/SMC-MQ-CPU/raw/main/cpu_blueprints/$bppath/blueprint.json"; then
    echo "Cannot download \"https://github.com/UltraQbik/SMC-MQ-CPU/raw/main/cpu_blueprints/$bppath/blueprint.json\", stopping..."
    exit 1
fi
if ! wget -O "$slpath/workshop/387990/$bppath/description.json" "https://github.com/UltraQbik/SMC-MQ-CPU/raw/main/cpu_blueprints/$bppath/description.json"; then
    echo "Cannot download \"https://github.com/UltraQbik/SMC-MQ-CPU/raw/main/cpu_blueprints/$bppath/description.json\", stopping..."
    exit 1
fi
if ! wget -O "$slpath/workshop/387990/$bppath/icon.png" "https://github.com/UltraQbik/SMC-MQ-CPU/blob/main/cpu_blueprints/$bppath/icon.png?raw=true"; then
    echo "Cannot download \"https://github.com/UltraQbik/SMC-MQ-CPU/blob/main/cpu_blueprints/$bppath/icon.png?raw=true\""
    exit 1
fi
echo "Done"
