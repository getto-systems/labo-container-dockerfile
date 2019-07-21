#!/bin/bash

set -x

export HOME=$(pwd)

image=getto/labo-container

docker build -t $image:${CI_COMMIT_SHORT_SHA} . && \
dockle --exit-code 1 $image:${CI_COMMIT_SHORT_SHA} && \
trivy --exit-code 1 --quiet --ignore-unfixed --auto-refresh $image:${CI_COMMIT_SHORT_SHA} && \
:
