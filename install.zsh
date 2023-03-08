#!/usr/bin/env zsh
set -e

pushd ${0:A:h}

# Ensure dependencies are up to date
git submodule update --init

# Ensure npm is installed and run
if (( $+commands[npm] )); then
    [ -f package-lock.json ] && npm update
    [ -f package-lock.json ] && npm ci || npm i
else
    popd
    echo "npm is not installed"
    exit 1
fi

# Ensure php is installed and run
if (( $+commands[php] )); then
    ./bin/composer install
else
    popd
    echo "php is not installed"
    exit 1
fi


echo "Install complete"
echo "You must sylink bin/wvim to a bin directory in PATH"
