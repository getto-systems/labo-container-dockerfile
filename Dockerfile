FROM buildpack-deps:cosmic
MAINTAINER shun

ENV LABO_USER laboratory
ENV BUILD_LABO_USER $LABO_USER

ENV NODE_VERSION 10

RUN set -x && \
    apt-get update && \
    apt-get install -y \
      sudo \
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
      neovim \
      uidmap \
    && \
    echo '%sudo  ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    apt-add-repository ppa:fish-shell/release-3 && \
    apt-get update && \
    apt-get install -y fish && \
    curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash - && \
    apt-get install -y nodejs && \
    curl -sSL https://get.docker.com | sh && \
    apt-get clean && \
    groupmod -g 233 docker && \
    useradd $LABO_USER -s /bin/bash && \
    :

COPY entrypoint.sh /usr/local/bin

ENTRYPOINT ["entrypoint.sh"]
CMD ["/usr/bin/fish"]
