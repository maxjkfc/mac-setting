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

    ln -s $PWD/vim/max $HOME/.vim/config
    ln -s $PWD/vim/colors $HOME/.vim/colors
    
    if [ "$vim_type" == 'vim' ]; then 
        ln -s $PWD/vim/.vimrc $HOME/.vimrc
        vim +PlugInstall
        vim +GoInstallBinaries
    else
        ln -s $PWD/vim/.vimrc $HOME/.config/nvim/init.vim
        # coc config
        ln -s $PWD/vim/config/coc-settings.json $HOME/.config/nvim/coc-settings.json

        nvim +PlugInstall
        nvim +GoInstallBinaries

        # coc
        nvim -c 'CocInstall -sync coc-highlight  coc-json coc-css coc-html coc-tsserver coc-yaml coc-rls coc-snippets coc-explorer coc-tabnine coc-prettier coc-lists coc-git coc-pairs|q'
        install_app_for_neovim
    fi

    install_app_for_vim
}

install_app_for_vim() {
    # Fonts
    brew tap caskroom/fonts
    brew cask install font-hack-nerd-font
    # install clang-format for vim
    brew install clang-format
    # Install Node.js
    brew install npm
    # install dockerfile lsp
    npm install -g dockerfile-language-server-nodejs
    # install bash lsp
    npm i -g bash-language-server
    # install python lsp
    pip install python-language-server

}
install_app_for_neovim() {
    pip3 install pynvim
    sudo gem install neovim
    npm -i install neovim
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
