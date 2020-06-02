#/bin/bash

set -e


setup(){

    brew install zplug  gawk git -y

    if [ ! -d '~/.zsh' ]; then
        mkdir -p ~/.zsh
    fi
    ln -s $PWD/zsh/.zshrc $HOME/.zshrc
    ln -s $PWD/zsh/config $HOME/.zsh/config

    source ~/.zshrc
}

setup



