FROM alpine:3.23.4
LABEL maintainer='Chris Kankiewicz <Chris@ChrisKankiewicz.com>'

# Minecraft version
ARG MC_VERSION=26.1.1
ARG MC_JAR_SHA1=49c8195703ad0ba4f0a4efbccfd85a4a8ca57431

# Set default JVM options
ENV _JAVA_OPTIONS="-Xms256M -Xmx1024M"

# Create Minecraft directories
RUN mkdir -pv /opt/minecraft /etc/minecraft

# Create non-root user
RUN adduser -DHs /sbin/nologin minecraft

# Add the EULA file
COPY files/eula.txt /etc/minecraft/eula.txt

# Add the ops script
COPY files/ops /usr/local/bin/ops
RUN chmod +x /usr/local/bin/ops

# Install dependencies, fetch Minecraft server jar file and chown files
ARG JAR_URL=https://piston-data.mojang.com/v1/objects/${MC_JAR_SHA1}/server.jar
RUN apk add --update ca-certificates eudev-dev nss openjdk25-jre-headless tzdata wget \
    && wget -O /opt/minecraft/minecraft_server.jar ${JAR_URL} \
    && apk del --purge wget && rm -rf /var/cache/apk/* \
    && chown -R minecraft:minecraft /etc/minecraft /opt/minecraft

# Define volumes
VOLUME /etc/minecraft

# Expose port
EXPOSE 25565

# Set running user
USER minecraft

# Set the working dir
WORKDIR /etc/minecraft

# Default run command
CMD ["java", "-jar", "/opt/minecraft/minecraft_server.jar", "nogui"]
