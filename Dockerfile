FROM buildpack-deps:cosmic
MAINTAINER shun

ENV LABO_USER laboratory
ENV BUILD_LABO_USER $LABO_USER

ENV NODE_VERSION 10
ENV DOCKER_GID 233

RUN set -x && \
    apt-get update && \
    apt-get install -y \
      setpriv \
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
    && \
    : "to fix vulnerabilities, update following packages" && \
    apt-get install -y \
      bzip2 \
      imagemagick \
      imagemagick-6.q16 \
      libbz2-1.0 \
      libglib2.0-data \
      libexpat1 \
      libglib2.0-0 \
      libmagickcore-6-arch-config \
      libpq-dev \
      libsqlite3-0 \
      linux-libc-dev \
    && \
    apt-add-repository ppa:fish-shell/release-3 && \
    apt-get update && \
    apt-get install -y fish && \
    curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash - && \
    apt-get install -y nodejs && \
    curl -sSL https://get.docker.com | sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    groupmod -g $DOCKER_GID docker && \
    useradd $BUILD_LABO_USER -s /bin/bash && \
    :

COPY entrypoint.sh /usr/local/bin

ENTRYPOINT ["entrypoint.sh"]
CMD ["/usr/bin/fish"]
