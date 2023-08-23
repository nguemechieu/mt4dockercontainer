# Use a base image
FROM ubuntu:latest
WORKDIR ./mt4dockercontainer
# Update package repositories and install wget


COPY  ./mt4ubuntu.sh ./mt4ubuntu.sh


RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update 


RUN wget https://download.mql5.com/cdn/web/metaquotes.software.corp/mt4/mt4ubuntu.sh ; chmod +x mt4ubuntu.sh ; ./mt4ubuntu.sh
