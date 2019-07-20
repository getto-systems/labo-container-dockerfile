#!/bin/bash

set -x

export HOME=$(pwd)

docker build -t getto/labo-container:${CI_COMMIT_SHORT_SHA} . && \
dockle --exit-code 1 getto/labo-container:${CI_COMMIT_SHORT_SHA} && \
trivy --exit-code 1 --quiet --ignore-unfixed --auto-refresh getto/labo-container:${CI_COMMIT_SHORT_SHA} && \
:
