#!/bin/bash

# Check to see what version of Plex is installed vs what is being requested. If requested version is different
# install that one 

INSTALLED=`dpkg-query -W -f='${Version}' plexmediaserver`

if [ -z "$VERSION" ]; then
    PLEX_URL=$(curl -sL http://plex.baconopolis.net/latest.php | sed -nr 's#(http.+?/plexmediaserver_.+?_amd64\.deb)#\1#p')
else
    PLEX_URL=$(curl -sL http://plex.baconopolis.net/version.php?version=${VERSION} | sed -nr 's#(http.+?/plexmediaserver_.+?_amd64\.deb)#\1#p')
fi
PLEX_VERSION=$(echo $PLEX_URL | awk -F_ '{print $2}')

if [ -z "$PLEX_VERSION" ]; then
    echo "Unable to get plex version"
    exit 0
fi
if [ "$PLEX_VERSION" = "$INSTALLED" ]; then
    echo "Version not changed - $PLEX_VERSION"
    /etc/service/plex/run
else
    # Don't uninstall the old version of plex if the download fails
    wget -q "${PLEX_URL}" -O /tmp/plexmediaserver_${PLEX_VERSION}_amd64.deb
    if [ $? -eq 0 ]; then
        if [ -n "$INSTALLED" ]; then
            echo "Updating Plex to $PLEX_VERSION from $INSTALLED"
            echo "Uninstalling  Plex version $INSTALLED"
            apt-get remove --purge -y plexmediaserver
        fi
        echo "Installed to Plex version $PLEX_VERSION"
        gdebi -n /tmp/plexmediaserver_${PLEX_VERSION}_amd64.deb
        /etc/init.d/plexmediaserver stop
        # Replace default config with our own
        cat /default_plexmediaserver > /etc/default/plexmediaserver
        # Fix a Debianism of plex's uid being 101
        usermod -u 999 plex
        usermod -g 100 plex
        rm -f /tmp/plexmediaserver_${PLEX_VERSION}_amd64.deb
        /etc/service/plex/run
        echo $PLEX_VERSION > /tmp/version
    else
        echo "Download failed, please try again later"
    fi
fi
