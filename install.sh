#!/bin/sh
# <------------------------------------------------------->
# (c) People
# Permission to do whatever you want with this thing, except
# for erasing all copies from the world, is hereby granted.
# <------------------------------------------------------->
# MQ install script:

DEFAULT_SL_PATH="/home/$(logname)/.local/share/Steam/steamapps/"
DEFAULT_MQ_VER="1_1"

printf "Enter path to steamapps ($DEFAULT_SL_PATH): "
read slpath
slpath=${slpath:-"$DEFAULT_SL_PATH"}
if ! [ -d "$slpath" ]; then
    echo "Folder \"$slpath\" doesn't exist!"
    exit 1
fi

printf "Enter MQ version ($DEFAULT_MQ_VER): "
read mqver
mqver=${mqver:-"$DEFAULT_MQ_VER"}

bppath="MQr$mqver"

if ! wget -O- "https://github.com/UltraQbik/SMC-MQ-CPU/raw/main/cpu_blueprints/$bppath" > /dev/null 2>&1; then
    echo "There's no such version of MQ!"
    exit 1
fi

echo "Downloading..."
mkdir -p "$slpath/workshop/content/387990/$bppath"
echo " blueprint.json..."
if ! wget -O "$slpath/workshop/content/387990//$bppath/blueprint.json" "https://github.com/UltraQbik/SMC-MQ-CPU/raw/main/cpu_blueprints/$bppath/blueprint.json" > /dev/null 2>&1; then
    echo "Cannot download \"https://github.com/UltraQbik/SMC-MQ-CPU/raw/main/cpu_blueprints/$bppath/blueprint.json\", stopping..."
    exit 1
fi
echo " description.json..."
if ! wget -O "$slpath/workshop/content/387990/$bppath/description.json" "https://github.com/UltraQbik/SMC-MQ-CPU/raw/main/cpu_blueprints/$bppath/description.json" > /dev/null 2>&1; then
    echo "Cannot download \"https://github.com/UltraQbik/SMC-MQ-CPU/raw/main/cpu_blueprints/$bppath/description.json\", stopping..."
    exit 1
fi
echo " icon.png..."
if ! wget -O "$slpath/workshop/content/387990/$bppath/icon.png" "https://github.com/UltraQbik/SMC-MQ-CPU/blob/main/cpu_blueprints/$bppath/icon.png?raw=true" > /dev/null 2>&1; then
    echo "Cannot download \"https://github.com/UltraQbik/SMC-MQ-CPU/blob/main/cpu_blueprints/$bppath/icon.png?raw=true\""
    exit 1
fi
echo "Done"
