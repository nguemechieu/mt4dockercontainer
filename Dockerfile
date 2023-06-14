FROM suchja/wine:latest
USER root
RUN mkdir -p /softwares/mt4/MQL4/Experts
RUN wget https://download.mql5.com/cdn/web/metaquotes.software.corp/mt4/mt4ubuntu.sh 
RUN chmod +x mt4ubuntu.sh  
RUN ./mt4ubuntu.sh
WORKDIR Home directory\.mt4\drive_c\Program Files\MetaTrader 4
EXPOSE 8080
