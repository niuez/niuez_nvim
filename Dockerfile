FROM alpine:latest

# マルチバイト文字をまともに扱うための設定
ENV LANG="en_US.UTF-8" LANGUAGE="en_US:ja" LC_ALL="en_US.UTF-8"

# 最低限必要なパッケージ
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    build-base \
    curl \
    git \
    libxml2-dev \
    libxslt-dev \
    musl-dev\
    neovim \
    nodejs \
    npm \
    python3-dev \
    py3-pip \
    && \
    rm -rf /var/cache/apk/*

RUN pip3 install --upgrade pip neovim

# install dein.vim
RUN curl -sf https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh \
    | sh -s /root/.vim/dein

COPY nvim /root/.config/nvim

RUN nvim +:UpdateRemotePlugins +qa
RUN nvim -c "call dein#install()" +qa
RUN nvim -c "CocInstall -sync coc-explorer" +qa
RUN chmod -R 777 /root

WORKDIR /content

ENTRYPOINT ["nvim"]
