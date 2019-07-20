#!/bin/sh

image=getto/labo-container
version=$(cat .release-version)

echo $DOCKER_PASSWORD | docker login -u $DOCKER_USER --password-stdin && \
docker pull --disable-content-trust $image:$version && \
docker tag $image:$version $image:latest && \
docker push $image:latest && \
docker push $image:$version && \
:

: # always success
