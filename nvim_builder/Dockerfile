FROM debian:bullseye as builder

RUN apt-get update && apt-get install -y git ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/cache/apt/archives/*

RUN git clone --depth=1 https://github.com/neovim/neovim \
    && cd neovim \
    && make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=/nvim" \
    && make install \
    && rm -rf neovim

FROM debian:bullseye

COPY --from=builder /nvim /nvim
ENV PATH=$PATH:/nvim/bin

ENTRYPOINT ["nvim"]
