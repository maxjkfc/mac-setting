#/bin/bash

set -e


setup(){

    if [ ! -d '~/.zsh' ]; then
        mkdir -p ~/.zsh
    fi
    
    ln -s $PWD/zsh/.zshrc $HOME/.zshrc

    ln -s $PWD/zsh/max $HOME/.zsh/max

    #cp $PWD/zsh/themes/* $ZSH/themes/

    brew tap sambadevi/powerlevel9k

    brew install powerlevel9k

    source ~/.zshrc
    
}

setup



