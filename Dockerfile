# Use a base image
FROM ubuntu:latest

# Update package repositories and install wget
RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

# Set a default working directory

RUN  apt-get install -y wget

RUN apt-get install -y wget && wget https://download.mql5.com/cdn/web/metaquotes.software.corp/mt4/mt4ubuntu.sh ;
RUN chmod +x mt4ubuntu.sh ; 
RUN mt4ubuntu.sh
