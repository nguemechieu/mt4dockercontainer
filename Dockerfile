# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install necessary dependencies, including curl
RUN apt-get update -y && \
    apt-get install -y \
    software-properties-common \
    x11vnc \
    xvfb \
    curl \
    && apt-get clean

# Add Wine repository and install Wine
RUN dpkg --add-architecture i386 && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update -y && \
    apt-get install -y \
    wine64 \
    wine32 \
    python3.8 \
    && apt-get clean

# Download MetaTrader 4 installer and install it using Wine
RUN mkdir /mt4
WORKDIR /mt4

# Use curl to download the MetaTrader 4 installer
RUN curl -o mt4setup.exe https://download.mql5.com/cdn/web/metaquotes.software.corp/mt4/mt4setup.exe

# Install MetaTrader 4 using Wine
RUN wine mt4setup.exe /S /D=C:\mt4

# Verify MetaTrader 4 installation and functionality
RUN wine C:\mt4\\terminal.exe /s && echo "MetaTrader 4 installed successfully."

# Create a command to launch MetaTrader 4 in a virtual screen
RUN echo '#!/bin/sh' >> /usr/local/bin/launch-mt4 && \
    echo 'Xvfb :1 -screen 0 1024x768x16 & sleep 5 && DISPLAY=:1 wine "C:\mt4\\terminal.exe"' >> /usr/local/bin/launch-mt4 && \
    chmod +x /usr/local/bin/launch-mt4

# Cleanup
RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /mt4

# Set the working directory to root
WORKDIR /

# Command to launch MetaTrader 4
CMD ["launch-mt4"]
