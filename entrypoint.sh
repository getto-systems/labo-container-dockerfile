#!/bin/bash

groupmod -n $LABO_USER $BUILD_LABO_USER
usermod -l $LABO_USER -d /home/$LABO_USER -g $LABO_USER -G $LABO_USER,docker $BUILD_LABO_USER

exec setpriv --reuid $LABO_USER --regid $LABO_USER --init-groups --reset-env "$@"
