Docker NFS Server
================

Usage
----
```bash
docker run -d --name nfs-client ryanckoch/nfs-client nfs_server1.domain.com:/path/on/nfs/server1:/path/on/client1 nfs_server2.domain.com:/path/on/nfs/server2:/path/on/client2
``` 
