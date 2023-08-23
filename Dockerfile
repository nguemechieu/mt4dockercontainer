# Use a base image with wine already installed (you can replace this with a suitable wine image)
FROM ubuntu:latest

# Update package repositories and install additional tools
RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

# Copy your script to the container

# Copyright 2022, MetaQuotes Ltd.

# MetaTrader download url
URL="https://download.mql5.com/cdn/web/metaquotes.software.corp/mt4/mt4oldsetup.exe"
# Wine version to install: stable or devel
WINE_VERSION="stable"

# Prepare: switch to 32 bit and add Wine key
RUN dpkg --add-architecture i386
RUN  mkdir -pm755 /etc/apt/keyrings
RUN wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

# Get Ubuntu version and trim to major only
OS_VER=$(lsb_release -r |cut -f2 |cut -d "." -f1)
# Choose repository based on Ubuntu version
if (( $OS_VER >= 23)); then
  RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/lunar/winehq-lunar.sources
elif (( $OS_VER < 23 )) && (( $OS_VER >= 22 )); then
  RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources
elif (( $OS_VER < 22 )) && (( $OS_VER >= 21 )); then
  RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/impish/winehq-impish.sources
elif (( $OS_VER < 21 )) && (( $OS_VER >= 20 )); then
  RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/focal/winehq-focal.sources
elif (( $OS_VER < 20 )); then
  RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/bionic/winehq-bionic.sources
fi

# Update package and install Wine
RUN apt update
RUN apt upgrade
RUN apt-get  install -y --install-recommends winehq-$WINE_VERSION

# Download MetaTrader
RUN wget $URL -O mt4setup.exe

# Set environment to Windows 10
RUN WINEPREFIX=~/.mt4 WINEARCH=win32 winecfg -v=win10
# Start MetaTrader installer in 32 bit environment
RUN WINEPREFIX=~/.mt4 WINEARCH=win32 wine mt4setup.exe


