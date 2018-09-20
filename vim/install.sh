#/bin/bash

set -e

vim_type=$1

install_vim(){
    ln -s $PWD/vim/.vimrc $HOME/.vimrc
    ln -s $PWD/vim/.vimrc.bundles $HOME/.vimrc.bundles
    ln -s $PWD/colors/molokai-max.vim $HOME/.vim/colors/molokai-max.vim
}

install_nvim(){
    ln -s $PWD/nvim $HOME/.config/nvim
}

check_vimdir() {
    if [ ! -d '~/.vim' ]; then
        mkdir -p ~/.vim
    fi

    if [ ! -d '~/colors' ]; then
        mkdir -p ~/.vim/colors
    fi
}

check_nvimdir(){
    if [ ! -d '~/.config' ]; then
        mkdir -p  ~/.config
    fi
}

case $vim_type in
    "vim")
        check_vimdir
        install_vim
        ;;
    "neovim","nvim")
        check_nvimdir
        install_nvim
        ;;
    *)
        echo "Please Input the vim / nvim"
        exit 0
        ;;
esac


