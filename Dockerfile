# Use a base image
FROM ubuntu:latest
WORKDIR ./mt4dockercontainer
# Update package repositories and install wget


COPY  ./mt4ubuntu.sh ./mt4ubuntu.sh
RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

# Set a default working directory
RUN chmod +x mt4ubuntu.sh ; 
RUN bash mt4ubuntu.sh
