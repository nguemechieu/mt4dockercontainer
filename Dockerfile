FROM ubuntu:latest
RUN apt-get update
RUN  apt install -y wget
RUN apt-get install -y  apt-utils

RUN wget http://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86.msi

RUN apt-get install -y wine
RUN winecfg
RUN dpkg --add-architecture i386 && apt-get update &&
RUN apt-get install wine32

EXPOSE 9000

CMD ["wine", "metatrader.exe"]
