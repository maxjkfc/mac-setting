#/bin/bash

set -e

setup_vim() {

    if [ ! -d '~/.vim' ]; then
        mkdir -p ~/.vim
    fi

    if [ ! -d "$HOME/.vimswp" ]; then
        mkdir -p $HOME/.vimswp
    fi
    if [ ! -d "$HOME/.vimbackup" ]; then
        mkdir -p $HOME/.vimbackup
    fi
    if [ ! -d "$HOME/.vimundo" ]; then
        mkdir -p $HOME/.vimundo
    fi

    if [ ! -f '~/.vim/autoload/plug.vim' ]; then
        echo "Check the vim-plug no exist , Install vim-plug"
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    if [ -d "$HOME/.vim/config" ]; then
        rm -rf $HOME/.vim/config
    fi

    if [ -d "$HOME/.vim/colors" ]; then
        rm -rf $HOME/.vim/colors
    fi

    ln -s $PWD/vim/max $HOME/.vim/config
    ln -s $PWD/vim/colors $HOME/.vim/colors

    if [ ! -d "$HOME/.config/nvim" ]; then
        mkdir -p $HOME/.config/nvim
    fi

    if [ -f "$HOME/.config/nvim/init.vim" ]; then
        rm -rf $HOME/.config/nvim/init.vim
    fi
    ln -s $PWD/vim/.vimrc $HOME/.config/nvim/init.vim
    # coc config
    if [ -f "$HOME/.config/nvim/coc-settings.json" ]; then
        rm -rf $HOME/.config/nvim/coc-settings.json
    fi
    ln -s $PWD/vim/config/coc-settings.json $HOME/.config/nvim/coc-settings.json

    install_app_for_neovim

    # Plugin
    nvim -c 'PlugInstall' +qall
    nvim -c 'GoInstallBinaries' +qall
    # coc
    echo 'install coc plugins'
    nvim -c 'CocInstall -sync coc-highlight  coc-json coc-css coc-html coc-tsserver coc-yaml coc-rls coc-snippets coc-explorer coc-tabnine coc-prettier coc-lists coc-git coc-pairs' +qall

    install_vim_app
}

install_vim_app() {
    echo "vim_app"
    # Fonts
    brew tap homebrew/cask-fonts
    brew cask install font-hack-nerd-font
    # install clang-format for vim
    brew install clang-format
    # install dockerfile lsp
    npm install -g dockerfile-language-server-nodejs
    # install bash lsp
    npm i -g bash-language-server
    # install python lsp
    pip3 install python-language-server

}

install_app_for_neovim() {
    pip3 install pynvim
    sudo gem install neovim
    npm -i install neovim
}
