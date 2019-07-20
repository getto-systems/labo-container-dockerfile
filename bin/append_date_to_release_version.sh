#!/bin/bash

sed -i -e "s|$|-$(date +%Y%m%d%H%M%S)|" .release-version
