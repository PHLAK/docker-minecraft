docker-minecraft
================

Docker image for [Minecraft](https://minecraft.net/) server.

[![](https://badge.imagelayers.io/phlak/minecraft:latest.svg)](https://imagelayers.io/?images=phlak/minecraft:latest 'Get your own badge on imagelayers.io')


### Running the container

First create a named data volume to hold the persistent world and config data:

    docker volume create --name minecraft-data

Then run the Minecraft server:

    docker run -d -p 25565:25565 -v minecraft-data:/etc/minecraft --name minecraft-server phlak/minecraft


##### Adding OPs

Once you have a running server container you can add OPs by running:

    docker exec minecraft-server ops [PLAYER_NAMES]

**NOTE:** Replace `[PLAYER_NAMES]` with the name of one or more players you wish to give OP
privileges separated by a space. If a players name contains spaces wrap it in quotation marks.

Here's an example granting OP to three players with name's `Marty`, `Jennifer` and  `Doc Brown`:

    docker exec minecraft-server ops Marty Jennifer "Doc Brown"


##### Optional 'docker run' Arguments

`-e _JAVA_OPTIONS='-Xms256M -Xmx2048M'` - Set JVM arguments for minimum/maximum memory consumption
                                          (default: '-Xms256M -Xmx2048M')

`--restart always` - Always restart the container regardless of the exit status. See the Docker
                     [restart policies](https://goo.gl/OI87rA) for additional details.

**NOTE:** See the [Minecraft Wiki](http://minecraft.gamepedia.com/Server/Requirements) for more info
on memory requirements.


##### Editing the server config

Once you have a running container, you can edit the Minecraft server config with:

    docker exec -it minecraft-server vi /etc/minecraft/server.properties

After saving changes, restart your container with `docker restart minecraft-server`


### Upgrading the server

First pull down the latest image:

    docker pull phlak/minecraft

Remove your running server container:

    docker rm -f minecraft-server

And run a new one with the same command/arguments as before.

Troubleshooting
---------------

Please report bugs to the [GitHub Issue Tracker](https://github.com/PHLAK/docker-minecraft/issues).

Copyright
---------

This project is liscensed under the [MIT License](https://github.com/PHLAK/docker-minecraft/blob/master/LICENSE).
