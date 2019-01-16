#/bin/bash

set -e

vim_type=$1

setup_vim(){

    if [ ! -d '~/.vim' ]; then
        mkdir -p ~/.vim
    fi
    

    if [ ! -f '~/.vim/autoload/plug.vim' ]; then
        echo "Check the vim-plug no exist , Install vim-plug"
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    ln -s $PWD/vim/max $HOME/.vim/max
    ln -s $PWD/vim/colors $HOME/.vim/colors
    
    if [ "$vim_type" == 'vim' ]; then 
        ln -s $PWD/vim/.vimrc $HOME/.vimrc
        vim +PlugInstall
        vim +GoInstallBinaries
    else
        ln -s $PWD/vim/.vimrc $HOME/.config/nvim/init.vim
        nvim +PlugInstall
        nvim +GoInstallBinaries
    fi
}

check_nvimdir(){
    if [ ! -d "$HOME/.config/nvim" ]; then
        mkdir -p  $HOME/.config/nvim
    fi
}

case $vim_type in
    "vim")
        setup_vim
        ;;
    "nvim")
        check_nvimdir
        setup_vim
        ;;
    *)
        echo "Please Input the vim / nvim"
        exit 0
        ;;
esac


