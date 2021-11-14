FROM niuez/nvim_builder AS nvim_builder

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
