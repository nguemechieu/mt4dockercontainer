# Use a base image
FROM debian:latest
WORKDIR ./mt4dockercontainer
# Update package repositories and install wget


COPY  ./mt4ubuntu.sh ./mt4ubuntu.sh


RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*
env --add-architecture i386 
RUN apt-get update 
RUN apt-get install -y wine32


# Set a default working directory
RUN chmod +x mt4ubuntu.sh ; 
CMD   ./mt4ubuntu.sh
