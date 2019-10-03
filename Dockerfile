FROM ubuntu:disco

ENV LABO_USER laboratory
ENV BUILD_LABO_USER $LABO_USER

ENV NODE_VERSION 10
ENV DOCKER_GID 233

RUN set -x && \
  apt-get update && \
  apt-get install -y apt-utils && \
  apt-get install -y \
    ca-certificates \
    curl \
    git \
    util-linux \
    software-properties-common \
    locales \
    locales-all \
    language-pack-en \
    language-pack-en-base \
    language-pack-ja \
    language-pack-ja-base \
    man \
    manpages-dev \
    silversearcher-ag \
    tmux \
    less \
  && \
  : "to fix vulnerabilities, update packages : 2019-10-03" && \
  : apt-get install -y --no-install-recommends \
    libudev1 \
    openssl \
  && \
  : "install fish" && \
  apt-add-repository ppa:fish-shell/release-3 && \
  apt-get update && \
  apt-get install -y fish && \
  : "install docker" && \
  curl -sSL https://get.docker.com | sh && \
  : "install node" && \
  curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash - && \
  apt-get install -y nodejs && \
  : "install neovim" && \
  apt-add-repository ppa:neovim-ppa/stable && \
  apt-get update && \
  apt-get install -y neovim && \
  : "cleanup apt caches" && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  : "setup uid, gid" && \
  groupmod -g $DOCKER_GID docker && \
  useradd $BUILD_LABO_USER -s /bin/bash && \
  :

COPY entrypoint.sh /usr/local/bin

ENTRYPOINT ["entrypoint.sh"]
CMD ["/usr/bin/fish"]
