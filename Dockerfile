FROM alpine:3.12.0
LABEL maintainer='Chris Kankiewicz <Chris@ChrisKankiewicz.com>'

# Minecraft version
ARG MC_VERSION=1.16
ARG MC_JAR_SHA1=a0d03225615ba897619220e256a266cb33a44b6b

# Set jar file URL
ARG JAR_URL=https://launcher.mojang.com/v1/objects/${MC_JAR_SHA1}/server.jar

# Set default JVM options
ENV _JAVA_OPTIONS '-Xms256M -Xmx1024M'

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
RUN apk add --update ca-certificates nss openjdk8-jre-base tzdata wget \
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
