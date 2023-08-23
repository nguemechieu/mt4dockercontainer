#!/bin/bash

# Copyright 2022, MetaQuotes Ltd.

# MetaTrader download url
URL="https://download.mql5.com/cdn/web/metaquotes.software.corp/mt4/mt4oldsetup.exe"
# Wine version to install: stable or devel
WINE_VERSION="stable"

# Prepare: switch to 32 bit and add Wine key
sudo dpkg --add-architecture i386
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

# Get Ubuntu version and trim to major only
OS_VER=$(lsb_release -r |cut -f2 |cut -d "." -f1)
# Choose repository based on Ubuntu version
if (( $OS_VER >= 23)); then
  sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/lunar/winehq-lunar.sources
elif (( $OS_VER < 23 )) && (( $OS_VER >= 22 )); then
  sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources
elif (( $OS_VER < 22 )) && (( $OS_VER >= 21 )); then
  sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/impish/winehq-impish.sources
elif (( $OS_VER < 21 )) && (( $OS_VER >= 20 )); then
  sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/focal/winehq-focal.sources
elif (( $OS_VER < 20 )); then
  sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/bionic/winehq-bionic.sources
fi

# Update package and install Wine
sudo apt update
sudo apt upgrade
sudo apt install --install-recommends winehq-$WINE_VERSION

# Download MetaTrader
wget $URL -O mt4setup.exe

# Set environment to Windows 10
WINEPREFIX=~/.mt4 WINEARCH=win32 winecfg -v=win10
# Start MetaTrader installer in 32 bit environment
WINEPREFIX=~/.mt4 WINEARCH=win32 wine mt4setup.exe
