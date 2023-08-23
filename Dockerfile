# Use a base image
FROM debian:latest
WORKDIR ./mt4dockercontainer
# Update package repositories and install wget


COPY  ./mt4ubuntu.sh ./mt4ubuntu.sh


RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*
RUN   dpkg --add-architecture i386 && apt-get update &&apt-get install wine32


# Set a default working directory
RUN chmod +x mt4ubuntu.sh ; 
CMD   ./mt4ubuntu.sh
