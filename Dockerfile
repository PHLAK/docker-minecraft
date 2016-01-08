FROM alpine:3.3
MAINTAINER Chris Kankiewicz <Chris@ChrisKankiewicz.com>

# Minecraft version
ENV MC_VERSION 1.8.9

# Memory management
ENV MIN_MEM 256M
ENV MAX_MEM 2048M

# Create Minecraft directories
ENV SERVER_DIR  /opt/minecraft
ENV CONFIG_DIR  /etc/minecraft
RUN mkdir -pv ${SERVER_DIR} ${CONFIG_DIR}

# Add the EULA file
COPY files/eula.txt ${CONFIG_DIR}/eula.txt

# Add the ops script
COPY files/ops /bin/ops
RUN chmod +x /bin/ops

# Set jar file URL
ENV JAR_URL https://s3.amazonaws.com/Minecraft.Download/versions/${MC_VERSION}/minecraft_server.${MC_VERSION}.jar

# Install dependencies and fetch Minecraft server jar file
RUN apk add --update ca-certificates openjdk7-jre-base wget \
    && wget -O ${SERVER_DIR}/minecraft_server.jar ${JAR_URL} \
    && apk del ca-certificates wget && rm -rf /var/cache/apk/*

# Define Docker volumes
VOLUME ${CONFIG_DIR}

# Expose port
EXPOSE 25565

# Set the working dir
WORKDIR ${CONFIG_DIR}

# Default run command
CMD java -d64 -Xms${MIN_MEM} -Xmx${MAX_MEM} -jar ${SERVER_DIR}/minecraft_server.jar nogui
