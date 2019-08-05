#!/bin/bash

push_latest(){
  local image=getto/labo-container
  local result

  if [ -z "$tag" ]; then
    echo "tag not specified"
    exit 1
  fi

  echo "target: $image:$tag"

  docker pull $image:$tag > /dev/null
  if [ $? == 0 ]; then
    echo "already push signed image"
    return
  fi

  docker pull --disable-content-trust $image:$tag > /dev/null
  if [ $? != 0 ]; then
    echo "build not finished"
    return
  fi

  export HOME=$(pwd)

  mkdir -p $HOME/.docker/trust/private

  cat $DOCKER_CONTENT_TRUST_ROOT_KEY > $HOME/.docker/trust/private/$DOCKER_CONTENT_TRUST_ROOT_ID.key
  cat $DOCKER_CONTENT_TRUST_REPOSITORY_KEY > $HOME/.docker/trust/private/$DOCKER_CONTENT_TRUST_REPOSITORY_ID.key

  chmod 600 $HOME/.docker/trust/private/*.key

  cat $DOCKER_PASSWORD | docker login -u $DOCKER_USER --password-stdin && \
  docker tag $image:$tag $image:latest && \
  docker push $image:latest && \
  docker push $image:$tag && \
  :

  result=$?

  docker logout

  if [ $result != 0 ]; then
    exit 1
  fi
}

push_latest
