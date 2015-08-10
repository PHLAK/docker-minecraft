#!/usr/bin/env bash
set -o errexit

## Require argument
if [[ ! -z "${1}" ]]; then

    ## Set version number
    VERSION="${1}"

else

    ## Notify user of intent to update to latest version
    echo "NOTICE: No version number specified, updating to latest version"

    ## Set version to latest stable version
    VERSION="$(wget -qO- https://s3.amazonaws.com/Minecraft.Download/versions/versions.json | jq -r '.latest.release')"

fi

## Set the server URL
SERVER_URL="https://s3.amazonaws.com/Minecraft.Download/versions/${VERSION}/minecraft_server.${VERSION}.jar"

## Check if file exists
FILE_EXISTS="$(wget --spider -qO /dev/null ${SERVER_URL} && echo 'true' || echo 'false')"

## Error on non-existent server file
if [[ "${FILE_EXISTS}" == false ]]; then
    echo "ERROR: Unable to locate server file for version ${VERSION}"; exit 1
fi

## Fetch the server file
wget --verbose -O ${MC_DIR}/minecraft_server.update ${SERVER_URL}

## Notify user on success
echo "NOTICE: Updated server file has been downloaded. Restart the container to apply the update to version ${VERSION}"
