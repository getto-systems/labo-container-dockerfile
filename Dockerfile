FROM archlinux:latest

ENV LABO_USER laboratory
ENV BUILD_LABO_USER $LABO_USER

RUN set -x && \
  pacman -Syq --noconfirm \
    openssh \
    git \
    make \
    gcc \
    gettext \
    ncurses \
    asciidoc \
    docker \
    nodejs \
    npm \
    jq \
    coreutils \
    findutils \
    diffutils \
    grep \
    sed \
    gawk \
    less \
    which \
    tmux \
    neovim \
    python-pynvim \
    ripgrep \
  && \
  : "to fix vulnerabilities, update packages : 2020-02-13" && \
  : pacman -Uq --noconfirm \
    e2fsprogs \
    libcom-err2 \
    libext2fs2 \
    libss2 \
  && \
  : "install yash" && \
  cd /opt && \
  git clone https://github.com/magicant/yash && \
  cd yash && \
  ./configure --prefix=/usr && \
  make && \
  make install && \
  rm -rf /opt/yash && \
  ln -s /usr/bin/yash /usr/local/bin/sh && \
  cd / && \
  : "install npm packages" && \
  npm install -g \
    npm \
    textlint \
    textlint-rule-preset-ja-technical-writing \
    textlint-rule-write-good \
  && \
  rm -rf /root/.npm && \
  : "setup user" && \
  useradd $BUILD_LABO_USER -s /bin/bash && \
  :

COPY entrypoint.sh /usr/local/bin

ENTRYPOINT ["entrypoint.sh"]
CMD ["/usr/bin/yash"]
