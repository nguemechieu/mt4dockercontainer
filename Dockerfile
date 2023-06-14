FROM ubuntu:latest
RUN apt-get update
RUN  apt install -y wget
RUN apt-get install -y  apt-utils
RUN apt-get install -y wine
RUN winecfg
EXPOSE 9000
