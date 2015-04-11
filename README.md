This is a Dockerfile setup for Plex with built in NFS client.

This project is rework of the [needo37/plex](https://github.com/needo37/plex) and [cpuguy83/docker-nfs-client](https://github.com/cpuguy83/docker-nfs-client) projects.

To run the latest plexpass version with a local Plex config:

```
docker run -d --net="host" --name="plex" --privileged -v /path/to/local/config:/config -v /etc/localtime:/etc/localtime:ro -p 32400:32400 ryanckoch/docker-plex-nfs LOCAL_CONFIG nfs_server1.domain.com:/path/to/nfs/share1:/path/to/desired/mount1 nfs_server2.domain.com:/path/to/nfs/share2:/path/to/desired/mount2
```

To run a specific Plex version with a local Plex config:

```
docker run -d --net="host" --name="plex" --privileged -v /path/to/local/config:/config -v /etc/localtime:/etc/localtime:ro -e VERSION=0.9.9.8.436-8abe5c0 -p 32400:32400 ryanckoch/docker-plex-nfs LOCAL_CONFIG nfs_server1.domain.com:/path/to/nfs/share1:/path/to/desired/mount1 nfs_server2.domain.com:/path/to/nfs/share2:/path/to/desired/mount2
```

To run the latest plexpass version with a Plex config on an NFS share:

```
docker run -d --net="host" --name="plex" --privileged -v /etc/localtime:/etc/localtime:ro -p 32400:32400 ryanckoch/docker-plex-nfs REMOTE_CONFIG nfs_server1.domain.com:/path/to/nfs/plex_config nfs_server1.domain.com:/path/to/nfs/share1:/path/to/desired/mount1 nfs_server2.domain.com:/path/to/nfs/share2:/path/to/desired/mount2
```

To run a specific Plex version with a Plex config on an NFS share:
```
docker run -d --net="host" --name="plex" --privileged -v /etc/localtime:/etc/localtime:ro -e VERSION=0.9.9.8.436-8abe5c0 -p 32400:32400 ryanckoch/docker-plex-nfs REMOTE_CONFIG nfs_server1.domain.com:/path/to/nfs/plex_config nfs_server1.domain.com:/path/to/nfs/share1:/path/to/desired/mount1 nfs_server2.domain.com:/path/to/nfs/share2:/path/to/desired/mount2
```



NOTE: It can be the partial or full version name (e.g. 0.9.9.8 or 0.9.9.8.436-8abe5c0) replace with the version you desire in the command above
The VERSION variable supports versions listed on https://plex.tv/downloads/1/archive

If you exclude the VERSION tag it'll autoupdate to the latest version whenever you restart the container.

After install go to:

http://server:32400/web/index.html#!/dashboard and login with your myPlex credentials
