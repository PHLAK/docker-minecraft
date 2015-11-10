FROM alpine:3.2
MAINTAINER Chris Kankiewicz <Chris@ChrisKankiewicz.com>

# Set Minecraft directory
ENV MC_DIR /srv/minecraft

# Memory management
ENV MIN_MEM 512M
ENV MAX_MEM 2048M

# Upgrade packages and install dependencies
RUN apk add --update ca-certificates jq openjdk7-jre-base wget \
    && rm -rf /var/cache/apk/*

# Create Minecraft directry
RUN mkdir -p ${MC_DIR}

# Add and chmod update script
COPY files/update.sh ${MC_DIR}/update.sh
RUN chmod +x ${MC_DIR}/update.sh

# Download and install the Minecraft server jar
RUN ${MC_DIR}/update.sh

# Add the EULA file
COPY files/eula.txt ${MC_DIR}/eula.txt

# Define docker volumes
VOLUME ${MC_DIR}

# Expose ports
EXPOSE 25565

# Set the working dir
WORKDIR ${MC_DIR}

# Default command
CMD echo "${OP}" >> ${MC_DIR}/ops.txt; \
    [ -e "minecraft_server.update" ] && rm -f minecraft_server.jar && mv minecraft_server.update minecraft_server.jar; \
    java -Xms${MIN_MEM} -Xmx${MAX_MEM} -jar ${MC_DIR}/minecraft_server.jar nogui
