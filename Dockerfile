FROM python:3.6.5-stretch

ADD https://github.com/warpcode/docker-base-image/releases/download/v0.1.1/release.tar.gz /tmp/release.tar.gz
RUN tar xzf /tmp/release.tar.gz -C / && /etc/warpcode/install.sh && rm -f /tmp/release.tar.gz

RUN pkg_install\
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

RUN cd /usr/src\
        && git clone https://github.com/neovim/neovim.git\
        && cd neovim\
        && make CMAKE_BUILD_TYPE=RelWithDebInfo\
        CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=/usr/local" \
        && make install\
        && rm -r /usr/src/neovim

WORKDIR /data
VOLUME ["/data"]
ENTRYPOINT ["/entrypoint-user"]
CMD ["nvim"]
