FROM ubuntu:latest
RUN apt-get updates
RUN apt-get install  apt-utils
RUN wget https://download.mql5.com/cdn/web/metaquotes.software.corp/mt4/mt4ubuntu.sh ; chmod +x mt4ubuntu.sh ; ./mt4ubuntu.sh
EXPOSE 9000
