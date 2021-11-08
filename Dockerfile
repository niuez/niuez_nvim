FROM debian:bullseye-slim

# マルチバイト文字をまともに扱うための設定
ENV LANG="en_US.UTF-8" LANGUAGE="en_US:ja" LC_ALL="en_US.UTF-8"

RUN apt update && \
    apt install -y --no-install-recommends \
    git \
    neovim \
    nodejs \
    npm \
    ca-certificates \
    && \
    apt clean && \
    rm -rf /var/cache/apk/*

RUN git clone --depth=1 https://github.com/niuez/lyla.vim /root/.vim/lyla.vim
RUN git clone --depth=1 -b release --single-branch https://github.com/neoclide/coc.nvim /root/.vim/coc.nvim

COPY nvim/init.vim /root/.config/nvim/init.vim
COPY nvim/coc-settings.json /root/.config/nvim/coc-settings.json

RUN chmod -R 777 /root

WORKDIR /content

ENTRYPOINT ["nvim"]
