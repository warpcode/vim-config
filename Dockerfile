FROM python:3.6.5-stretch

ARG NVIM_BRANCH=master

ADD https://github.com/warpcode/docker-base-image/releases/download/v1.2.2/release.tar.gz /tmp/release.tar.gz
RUN tar xzf /tmp/release.tar.gz -C / && /etc/warpcode/install.sh && rm -f /tmp/release.tar.gz

RUN pkg-install\
        curl\
        ca-certificates\
        build-essential\
        git\
        nodejs\
        autoconf\
        automake\
        cmake \
        fish\
        g++\
        gettext\
        libtool\
        libtool-bin\
        lua5.3\
        ninja-build\
        pkg-config\
        unzip\
        xclip\
        xfonts-utils

RUN echo "Building neovim from branch ${NVIM_BRANCH}"\
        && cd /usr/src\
        && git clone --depth 1 --branch "${NVIM_BRANCH}" https://github.com/neovim/neovim.git\
        && cd neovim\
        && make CMAKE_BUILD_TYPE=RelWithDebInfo\
        CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=/usr/local"\
        && make install\
        && rm -r /usr/src/neovim

COPY . /home/app/src/warpcode/vim-config/
RUN cd /home/app/src/warpcode/vim-config/ && run-app -e -- make install-nvim

USER root
WORKDIR /data
VOLUME ["/data"]
ENTRYPOINT ["/entrypoint"]
CMD ["bash"]
