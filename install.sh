#!/bin/bash

sudo apt install neovim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
    --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim README.md -c PlugUpgrade q PlugInstall q PlugUpdate q 2> install.err

if [ -n install.err ]; then
    cat install.err
else:
    rm install.err
fi
