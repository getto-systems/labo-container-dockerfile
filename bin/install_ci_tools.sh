#!/bin/bash

set -x

apk -Uuv add bash git curl tar sed grep && \
./bin/install_dockle.sh && \
./bin/install_trivy.sh && \
:
