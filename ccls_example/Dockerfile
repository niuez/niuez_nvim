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
COPY nvim /root/.config/nvim
RUN git clone --depth=1 https://github.com/niuez/lyla.vim /root/.vim/lyla.vim
RUN git clone --depth=1 https://github.com/neovim/nvim-lspconfig /root/.vim/nvim-lspconfig
RUN git clone --depth=1 https://github.com/octol/vim-cpp-enhanced-highlight /root/.vim/vim-cpp-enhanced-highlight
RUN git clone --depth=1 https://github.com/ray-x/lsp_signature.nvim /root/.vim/lsp_signature.nvim
RUN git clone --depth=1 https://github.com/L3MON4D3/LuaSnip /root/.vim/LuaSnip
RUN git clone --depth=1 https://github.com/nvim-treesitter/nvim-treesitter /root/.vim/nvim-treesitter && nvim -c ":TSUpdateSync" -c ":TSInstallSync cpp" -c ":q"

RUN chmod -R 777 /root

WORKDIR /content

ENTRYPOINT ["nvim"]
CMD ["sh"]
