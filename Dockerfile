FROM ubuntu:20.04

ADD https://github.com/warpcode/docker-base-image/releases/download/v1.2.2/release.tar.gz /tmp/release.tar.gz
RUN tar xzf /tmp/release.tar.gz -C / && /etc/warpcode/install.sh && rm -f /tmp/release.tar.gz

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash\
    && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg >/dev/null\
    && echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN pkg-install software-properties-common\
    && add-apt-repository ppa:neovim-ppa/unstable\
    && pkg-install\
        composer\
        gcc\
        g++\
        git\
        lua5.3\
        make\
        neovim\
        nodejs\
        php\
        php-dom\
        php-mbstring\
        python3\
        python3-pip\
        unzip\
        xclip\
        xfonts-utils\
        yarn

# RUN npm install -g bash-language-server\
#     && npm install -g vim-language-server\
#     && npm install -g dockerfile-language-server-nodejs

RUN run-app -e -- mkdir -p /home/app/src/warpcode/vim-config/
WORKDIR /home/app/src/warpcode/vim-config/
COPY . .
RUN run-app -e -- make install-nvim

RUN run-app -e -- python3 -m pip install --user --upgrade pynvim\
    && run-app -e -- npm run neovim

USER root
WORKDIR /data
VOLUME ["/data"]
ENTRYPOINT ["/entrypoint"]
CMD ["bash"]
