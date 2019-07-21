#!/bin/bash

VERSION=$(
  curl --silent "https://api.github.com/repos/knqyf263/trivy/releases/latest" | \
  grep '"tag_name":' | \
  sed -E 's/.*"v([^"]+)".*/\1/' \
) && \
curl -L -o trivy.tar.gz https://github.com/knqyf263/trivy/releases/download/v${VERSION}/trivy_${VERSION}_Linux-64bit.tar.gz && \
tar zxvf trivy.tar.gz && \
mv trivy /usr/bin && \
:
