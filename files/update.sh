#!/usr/bin/env bash

## Require argument
if [[ -z "${1}" ]]; then
    echo "Usage: $(basename ${0}) [MINECRAFT_SERVER_JAR_URL]"; exit 1
fi

## Fetch the server file
wget -O /srv/minecraft/minecraft_server.update ${1} || exit 1

## Notify user on success
echo "NOTICE: Updated server file has been downloaded. Restart the container to apply the update."
