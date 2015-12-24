docker-minecraft
================

Docker container for Minecraft server.

[![](https://badge.imagelayers.io/phlak/minecraft:latest.svg)](https://imagelayers.io/?images=phlak/minecraft:latest 'Get your own badge on imagelayers.io')


### Running the container

First create a data-only container to hold the persistent world and config data:

    docker run --name minecraft-data phlak/minecraft echo "Data-only container for Minecraft server"

Then run the Minecraft server:

    docker run -d -e OP=[PLAYER_NAME] -p 25565:25565 --volumes-from minecraft-data --restart=always --name minecraft-server phlak/minecraft

**NOTE:** Replace `[PLAYER_NAME]` with the name of the first player you wish to give OP privileges.


##### Optional Arguments

`-e MIN_MEM=256M` - The minimum memory for the server to reserve (default: 256M)

`-e MAX_MEM=2048M` - The maximum memory for the server to consume (default: 2048M)

**NOTE:** See the [Minecraft Wiki](http://minecraft.gamepedia.com/Server/Requirements) for more info
on memory requirements.


##### Edit the server config

Once you have a running container, you can edit the Minecraft server config with:

    docker exec -it minecraft-server vi /srv/minecraft/server.properties

After saving changes, restart your container with `docker restart minecraft-server`


-----

**Copyright (c) 2015 Chris Kankewicz <Chris@ChrisKankiewicz.com>**

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
