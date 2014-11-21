FROM ubuntu:14.04
MAINTAINER Chris Kankiewicz <Chris@ChrisKankiewicz.com>

## Perform apt update / upgrade
RUN apt-get update && apt-get -y upgrade

## Install Minecraft dependencies
RUN apt-get -y install jq openjdk-7-jre-headless wget

## Create Minecraft directry
RUN mkdir /srv/minecraft


## Add and chmod update script
ADD files/update.sh /srv/minecraft/update.sh
RUN chmod +x /srv/minecraft/update.sh

## Download and install the Minecraft server deb
RUN /srv/minecraft/update.sh

## Add the EULA file
ADD files/eula.txt /srv/minecraft/eula.txt

## Perform apt cleanup
RUN apt-get -y autoremove && apt-get -y clean && apt-get -y autoclean

## Add and chmod the run file
ADD files/run.sh /srv/minecraft/run.sh
RUN chmod +x /srv/minecraft/run.sh

## Define docker volumes
VOLUME /srv/minecraft

## Expose ports
EXPOSE 25565

## Set the working dir
WORKDIR /srv/minecraft

## Default command
CMD ["./run.sh"]
