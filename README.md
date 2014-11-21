docker-minecraft
===================

Docker container for Minecraft server.


### Running the container

    docker run -d -p 25565:25565 -e OP=[PLAYER_NAME] -v /srv/minecraft --name Minecraft phlak/minecraft

**NOTE:** Replace `[PLAYER_NAME]` with the name of the player you wish to receive OP privileges.


### Updating your server

Update to latest version:

    docker exec Minecraft /srv/minecraft/update.sh

Update to a specific version:

    docker exec Minecraft /srv/minecraft/update.sh [SERVER_VERSION]

-----

**Copyright (c) 2014 Chris Kankewicz <Chris@ChrisKankiewicz.com>**

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
