FROM suchja/wine:latest
USER root
RUN mkdir -p /softwares/mt4/MQL4/Experts
RUN wget https://download.mql5.com/cdn/web/metaquotes.software.corp/mt4/mt4ubuntu.sh 
RUN chmod +x mt4ubuntu.sh  
RUN ./mt4ubuntu.sh
COPY files/*.* /softwares/mt4/
COPY files/compiler /softwares/mt4/
COPY files/MQL4 /softwares/mt4/MQL4/
RUN chown -R xclient /softwares/mt4/
USER xclient
CMD cd /softwares/mt4 && ./compiler

