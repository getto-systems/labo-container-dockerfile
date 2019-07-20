#!/bin/sh

image=getto/labo-container
version=$(cat .release-version)

docker pull $image:$version
docker tag $image:$version $image:latest
