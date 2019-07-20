#!/bin/sh

image=getto/labo-container
version=$(cat .release-version)

push_latest(){
  docker pull $image:$version
  if [ $? == 0 ]; then
    return # already push signed image
  fi

  docker pull --disable-content-trust $image:$version
  if [ $? != 0 ]; then
    return # build not finished
  fi

  export HOME=$(pwd)

  mkdir -p $HOME/.docker/trust/private

  cat $DOCKER_CONTENT_TRUST_ROOT_KEY > $HOME/.docker/trust/private/$DOCKER_CONTENT_TRUST_ROOT_ID.key
  cat $DOCKER_CONTENT_TRUST_REPOSITORY_KEY > $HOME/.docker/trust/private/$DOCKER_CONTENT_TRUST_REPOSITORY_ID.key

  chmod 600 $HOME/.docker/trust/private/*.key

  cat $DOCKER_PASSWORD | docker login -u $DOCKER_USER --password-stdin && \
  docker tag $image:$version $image:latest && \
  docker push $image:latest && \
  docker push $image:$version && \
  :

  result=$?

  docker logout

  if [ $result != 0 ]; then
    exit 1
  fi
}

push_latest
