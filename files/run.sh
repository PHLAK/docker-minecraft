#!/usr/bin/env bash

## Get the scripts path
SCRIPT_PATH="$(dirname $(readlink -f ${0}))"

## Add OP user
if [[ ! -e "${SCRIPT_PATH}/ops.txt.converted" ]]; then
    if [[ ! -z "${OP}" ]]; then
        echo "${OP}" > ${SCRIPT_PATH}/ops.txt || exit 1
    fi
fi

## Apply updated server jar if file exists
if [[ -e "${SCRIPT_PATH}/minecraft_server.update" ]]; then

    ## Remove old server file
    rm -fv ${SCRIPT_PATH}/minecraft_server.jar || exit 1

    ## Move the updated server jar into place
    mv -v ${SCRIPT_PATH}/minecraft_server.update ${SCRIPT_PATH}/minecraft_server.jar || exit 1

fi

## Error if no server file found
if [[ ! -e "${SCRIPT_PATH}/minecraft_server.jar" ]]; then
    echo "ERROR: Could not find minecraft_server.jar"; exit 1
fi

## Launch Minecraft server
java -Xms256M -Xmx2048M -jar minecraft_server.jar nogui
