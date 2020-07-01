#/bin/bash

set -e


setup_zsh(){

    brew install zplug  gawk git 

    if [ ! -d '~/.zsh' ]; then
        mkdir -p ~/.zsh
    fi

    if [ -f "$HOME/.zshrc" ]; then 
        rm -rf ~/.zshrc
    fi
    ln -s $PWD/zsh/.zshrc $HOME/.zshrc

    if [ -d "$HOME/.zsh/config" ]; then
        rm -rf ~/.zsh/config
    fi
    ln -s $PWD/zsh/config $HOME/.zsh/config

    setup_zsh_completions_docker_compose

    source ~/.zshrc

}

setup_zsh_completions_docker_compose(){
    mkdir -p ~/.zsh/completion
    curl -L https://raw.githubusercontent.com/docker/compose/1.24.0/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose

}





