FROM ubuntu:14.04
MAINTAINER Chris Kankiewicz <Chris@ChrisKankiewicz.com>

## Upgrade packages and install dependencies
RUN apt-get update && apt-get -y upgrade \
    && apt-get -y install jq openjdk-7-jre-headless wget \
    && rm -rf /var/lib/apt/lists/*

## Create Minecraft directry
RUN mkdir /srv/minecraft

## Add and chmod update script
ADD files/update.sh /srv/minecraft/update.sh
RUN chmod +x /srv/minecraft/update.sh

## Download and install the Minecraft server deb
RUN /srv/minecraft/update.sh

## Add the EULA file
ADD files/eula.txt /srv/minecraft/eula.txt

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
