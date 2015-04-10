#!/bin/bash

set -e

mounts=( "$@" )
targets=()

rpcbind

for mnt in "${mounts[@]}"; do
  server=$(echo $mnt | awk -F':' '{ print $1 }')
  src=$(echo $mnt | awk -F':' '{ print $2 }')
  target=$(echo $mnt | awk -F':' '{ print $3 }')
  targets+=("$target")

  mkdir -p $target

  mount -t nfs -o proto=tcp,port=2049 $server:${src} ${target}
done

exec inotifywait -m "${targets[@]}"
