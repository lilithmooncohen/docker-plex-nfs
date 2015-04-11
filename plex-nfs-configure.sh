#!/bin/bash

set -e

arguments=( "$@" )
targets=()

rpcbind 

# Mount nfs shares from run command
i=0
for argument in "${arguments[@]}"; do
  if [ "$i" -eq 0 ]; then
    if [ "$argument" == "LOCAL_CONFIG" ]; then
      if [ ! -d /config ]; then
        mkdir /config
      fi
      i=$((i + 2))
    elif [ "$argument" == "REMOTE_CONFIG" ]; then
      if [ ! -d /config ]; then
        mkdir /config
      fi
      i=$((i + 1))
    else
      echo "INCORRECT USAGE"
      exit 1
    fi

  elif [ "$i" -eq 1 ]; then
    server=$(echo $argument | awk -F':' '{ print $1 }')
    src=$(echo $argument | awk -F':' '{ print $2 }')
    mount -t nfs -o proto=tcp,port=2049 $server:${src} /config       
    i=$((i + 1))
  
  else
    server=$(echo $argument | awk -F':' '{ print $1 }')
    src=$(echo $argument | awk -F':' '{ print $2 }')
    target=$(echo $argument | awk -F':' '{ print $3 }')
    targets+=("$target")
    mkdir -p $target  
    mount -t nfs -o proto=tcp,port=2049 $server:${src} ${target}       
    i=$((i + 1))
  fi
done

# Install Plex
bash installplex.sh

# Replace default config with our own
cat /default_plexmediaserver > /etc/default/plexmediaserver


# Fix a Debianism of plex's uid being 101
usermod -u 999 plex
usermod -g 100 plex

# Correct permissions on firstrun.sh to execute during container startup
chmod +x /etc/my_init.d/firstrun.sh

# Add Plex to runit
chmod +x /etc/service/plex/run

# Start Plex
/etc/service/plex/run
