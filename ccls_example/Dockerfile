FROM debian:bullseye AS nvim_builder

# build neovim
RUN apt-get update && apt-get install -y git ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/cache/apt/archives/*

RUN git clone --depth=1 https://github.com/neovim/neovim \
    && cd neovim \
    && make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=/nvim" \
    && make install \
    && rm -rf neovim

FROM gcc:11.2.0

# install language server ccls
RUN apt-get update && apt install -y ccls \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/cache/apt/archives/*

# install neovim from builder
COPY --from=nvim_builder /nvim /nvim
ENV PATH=$PATH:/nvim/bin

# setting for neovim
RUN git clone --depth=1 https://github.com/niuez/lyla.vim /root/.vim/lyla.vim
RUN git clone --depth=1 https://github.com/neovim/nvim-lspconfig /root/.vim/nvim-lspconfig
RUN git clone --depth=1 https://github.com/octol/vim-cpp-enhanced-highlight /root/.vim/vim-cpp-enhanced-highlight
RUN git clone --depth=1 https://github.com/octol/vim-cpp-enhanced-highlight.git /tmp/vim-cpp-enhanced-highlight \
  && mkdir -p ~/.config/nvim/after/syntax/ \
  && mv /tmp/vim-cpp-enhanced-highlight/after/syntax/cpp.vim ~/.config/nvim/after/syntax/cpp.vim \
  && rm -rf /tmp/vim-cpp-enhanced-highlight
COPY nvim /root/.config/nvim

RUN chmod -R 777 /root

WORKDIR /content

ENTRYPOINT ["nvim"]
CMD ["sh"]
