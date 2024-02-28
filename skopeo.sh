#!/bin/bash
set -e
echo "Setting Variables"
IMAGE="nginx-ib"
DATE=`date '+%Y%m%d-%H%M'`
podman login registry1.dso.mil -u $REGISTRY_USER -p $REGISTRY_TOKEN
echo "Running skopeo container"
podman run -it --rm \
  -v `pwd`:/sync:Z \
  registry1.dso.mil/ironbank/opensource/containers/skopeo sync \
  --src-creds=$REGISTRY_USER:$REGISTRY_TOKEN \
  --src yaml --dest dir /sync/$IMAGE.yml ./$IMAGE
echo "TARchiving Collected Image"
tar -cvzf /sync/$IMAGE-$DATE.tgz ./$IMAGE
echo "Complete"