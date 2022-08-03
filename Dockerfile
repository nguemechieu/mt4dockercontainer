FROM suchja/wine:latest
MAINTAINER nguemechieu@live.com
USER root
RUN mkdir -p /softwares/mt4/MQL4/Experts
COPY files/*.* /softwares/mt4/
COPY files/compiler /softwares/mt4/
COPY files/MQL4 /softwares/mt4/MQL4/
RUN chown -R xclient /softwares/mt4
USER xclient
CMD cd /softwares/mt4 && ./compiler

