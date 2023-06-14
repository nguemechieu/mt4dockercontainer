FROM ubuntu:latest
RUN apt-get update
RUN  apt install -y wget
RUN apt-get install -y  apt-utils
RUN dpkg --add-architecture i386 &&  apt-get install -y wine
RUN wget https://download.mql5.com/cdn/web/metaquotes.software.corp/mt4/mt4ubuntu.sh 
RUN chmod +x mt4ubuntu.sh 
RUN ./mt4ubuntu.sh
EXPOSE 9000
