FROM alpine:3.4
MAINTAINER Chris Kankiewicz <Chris@ChrisKankiewicz.com>

# Minecraft version
ENV MC_VERSION 1.11

# Set default JVM options
ENV _JAVA_OPTIONS '-Xms256M -Xmx2048M'

# Create Minecraft directories
RUN mkdir -pv /opt/minecraft /etc/minecraft

# Add the EULA file
COPY files/eula.txt /etc/minecraft/eula.txt

# Add the ops script
COPY files/ops /usr/local/bin/ops
RUN chmod +x /usr/local/bin/ops

# Set jar file URL
ENV JAR_URL https://s3.amazonaws.com/Minecraft.Download/versions/${MC_VERSION}/minecraft_server.${MC_VERSION}.jar

# Install dependencies and fetch Minecraft server jar file
RUN apk add --update ca-certificates openjdk8-jre-base tzdata wget \
    && wget -O /opt/minecraft/minecraft_server.jar ${JAR_URL} \
    && apk del --purge wget && rm -rf /var/cache/apk/*

# Define volumes
VOLUME /etc/minecraft

# Expose port
EXPOSE 25565

# Set the working dir
WORKDIR /etc/minecraft

# Default run command
CMD ["java", "-jar", "/opt/minecraft/minecraft_server.jar", "nogui"]
