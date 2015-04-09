This is a Dockerfile setup for plex with plexpass - http://plex.tv/

To run the latest plexpass version:

```
docker run -d --net="host" --name="plex" -v /path/to/plex/config:/mnt/plex_config -v /path/to/video/files1:/mnt/array1 -v /path/to/video/files2:/mnt/array2 -v /etc/localtime:/etc/localtime:ro ryanckoch/plex
```

If you would like to specify a specific version of plex to run:

```
docker run -d --net="host" --name="plex" -v /path/to/plex/config:/mnt/plex_config -v /path/to/video/files1:/mnt/array1 -v /path/to/video/files2:/mnt/array2 -v /etc/localtime:/etc/localtime:ro -e VERSION=0.9.9.8.436-8abe5c0 needo/plex
```

NOTE: It can be the partial or full version name (e.g. 0.9.9.8 or 0.9.9.8.436-8abe5c0) replace with the version you desire in the command above
The VERSION variable supports versions listed on https://plex.tv/downloads/1/archive

If you exclude the VERSION tag it'll autoupdate to the latest version whenever you restart the container.

After install go to:

http://server:32400/web/index.html#!/dashboard and login with your myPlex credentials
