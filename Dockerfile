FROM ubuntu:latest
RUN apt-get update
RUN  apt install -y wget
RUN apt-get install -y  apt-utils
RUN  mkdir -p /etc/apt/keyrings
RUN wget -O - https://dl.winehq.org/wine-builds/winehq.key | gpg --dearmor |  tee /etc/apt/keyrings/winehq-archive.key
#Download the source file:
RUN wget -nc https://dl.winehq.org/wine-builds/ubuntu/dists/$(lsb_release -sc)/winehq-$(lsb_release -sc).sources
# Move it into “/etc/apt/sources.list.d”:
RUN  mv winehq-$(lsb_release -sc).sources /etc/apt/sources.list.d/
RUN wget https://download.mql5.com/cdn/web/metaquotes.software.corp/mt4/mt4ubuntu.sh 
RUN chmod +x mt4ubuntu.sh 
RUN ./mt4ubuntu.sh
EXPOSE 9000
