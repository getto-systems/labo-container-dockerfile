#!/bin/bash

groupmod -n $LABO_USER $BUILD_LABO_USER
usermod -l $LABO_USER -d /home/$LABO_USER -g $LABO_USER -G $LABO_USER,docker $BUILD_LABO_USER

labo_container_env(){
  echo DOCKER_WRAPPER_VOLUMES=$DOCKER_WRAPPER_VOLUMES
  echo LABO_IP=$LABO_IP
}

labo_container_env > /home/$LABO_USER/.labo-container.env

exec setpriv --reuid $LABO_USER --regid $LABO_USER --init-groups --reset-env "$@"
