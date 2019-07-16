#!/bin/bash

groupmod -n $LABO_USER $BUILD_LABO_USER
usermod -l $LABO_USER -d /home/$LABO_USER -g $LABO_USER -G $LABO_USER,sudo,docker $BUILD_LABO_USER

exec sudo -E -H -u $LABO_USER "$@"
