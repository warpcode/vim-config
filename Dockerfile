FROM ubuntu:20.04

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

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash\
    && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg >/dev/null\
    && echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN pkg-install\
        curl\
        git\
        make\
        python3\
        python3-pip\
        lua5.3\
        nodejs\
        yarn\
        php\
        php-dom\
        php-mbstring\
        composer\
        unzip

RUN run-app -e -- python3 -m pip install --user --upgrade pynvim
RUN npm install -g neovim

# RUN npm install -g bash-language-server\
#     && npm install -g vim-language-server\
#     && npm install -g dockerfile-language-server-nodejs

COPY . /home/app/src/warpcode/vim-config/
RUN cd /home/app/src/warpcode/vim-config/ && run-app -e -- make install-nvim

USER root
WORKDIR /data
VOLUME ["/data"]
ENTRYPOINT ["/entrypoint"]
CMD ["bash"]
