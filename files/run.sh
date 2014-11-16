#!/usr/bin/env bash

## Get the scripts path
SCRIPT_PATH="$(dirname $(readlink -f ${0}))"

## Require argument
if [[ -z "${1}" ]]; then
    echo "Usage: $(basename ${0}) [MINECRAFT_SERVER_JAR]"; exit 1
fi

## Set server directory
SERVER_DIR="$(dirname ${1})"

## Add OP user
if [[ ! -e "${SERVER_DIR}/ops.txt.converted" ]]; then
    echo "${OP}" > ${SERVER_DIR}/ops.txt || exit 1
fi

## Launch Minecraft
java -Xms256M -Xmx2048M -jar ${1} nogui
