FROM ubuntu:eoan

ENV LABO_USER laboratory
ENV BUILD_LABO_USER $LABO_USER

ENV NODE_VERSION 13

RUN set -x && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get install -y \
    apt-utils \
    apt-transport-https \
  && \
  apt-get install -y \
    ca-certificates \
    software-properties-common \
    util-linux \
    curl \
    git \
    yash \
    silversearcher-ag \
    jq \
    less \
    tmux \
    neovim \
    locales \
    locales-all \
    language-pack-en \
  && \
  : "to fix vulnerabilities, update packages : 2020-02-13" && \
  : apt-get install -y --no-install-recommends \
    e2fsprogs \
    libcom-err2 \
    libext2fs2 \
    libss2 \
  && \
  : "setup yash as sh" && \
  ln -s /usr/bin/yash /usr/local/bin/sh && \
  : "install docker" && \
  curl -sSL https://get.docker.com | sed "s/docker-ce\$pkg_version/docker-ce-cli\$pkg_version/" | sh && \
  groupadd docker && \
  : "install node" && \
  curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash - && \
  apt-get install -y nodejs && \
  npm install -g \
    npm \
    textlint \
    textlint-rule-preset-ja-technical-writing \
    textlint-rule-write-good \
  && \
  rm -rf /root/.npm && \
  : "cleanup apt caches" && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  : "setup user" && \
  useradd $BUILD_LABO_USER -s /bin/bash && \
  : "setup locale" && \
  locale-gen en_US.utf8 && \
  :

COPY entrypoint.sh /usr/local/bin

ENTRYPOINT ["entrypoint.sh"]
CMD ["/usr/bin/yash"]
