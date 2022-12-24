#!/bin/bash

sudo apt install -y  \
    curl             \
    neovim           \
    yarn             \
    silversearcher-ag

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
    --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim README.md -c PlugInstall

if [ -n install.err ]; then
    cat install.err
else:
    rm install.err
fi
