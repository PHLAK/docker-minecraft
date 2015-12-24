FROM alpine:3.3
MAINTAINER Chris Kankiewicz <Chris@ChrisKankiewicz.com>

# Define Minecraft version
ENV MC_VERSION 1.8.9

# Memory management
ENV MIN_MEM 256M
ENV MAX_MEM 2048M

# Create Minecraft directories
ENV MC_BIN_DIR  /opt/minecraft
ENV MC_RUN_DIR  /srv/minecraft
RUN mkdir -pv ${MC_BIN_DIR} ${MC_RUN_DIR}

# Add the EULA file
COPY files/eula.txt ${MC_RUN_DIRq}/eula.txt

# Upgrade packages and install dependencies
RUN apk add --update ca-certificates openjdk7-jre-base wget \
    && rm -rf /var/cache/apk/*

# Download and install the Minecraft server jar
RUN wget --verbose -O ${MC_BIN_DIR}/minecraft_server.jar \
    https://s3.amazonaws.com/Minecraft.Download/versions/${MC_VERSION}/minecraft_server.${MC_VERSION}.jar

# Define Docker volumes
VOLUME ${MC_RUN_DIR}

# Expose port
EXPOSE 25565

# Set the working dir
WORKDIR ${MC_RUN_DIR}

# Default run command
CMD [ -z "$(grep '${OP}' ${MC_RUN_DIR}/ops.txt )" ] && echo "${OP}" >> ${MC_RUN_DIR}/ops.txt; \
    java -d64 -Xms${MIN_MEM} -Xmx${MAX_MEM} -jar ${MC_BIN_DIR}/minecraft_server.jar nogui
