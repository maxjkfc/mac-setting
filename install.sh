#/bin/bash

set -e

source $PWD/setup-zsh.sh
source $PWD/setup-vim.sh

install_brew(){
    echo "Install Ruby Brew ..."
    if  hash brew 2>/dev/null; then
        echo "brew is installed"
    else
         #Install Brew
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    brew update
}

# install zsh
install_zsh() {
    echo "Install Zsh ...."
    # zsh
    brew install zsh     
    chsh -s /bin/zsh
    # Install zsh plug 
    brew install zplug

    setup_zsh
}

# install vim
install_nvim() {
   
    # Install neovim
    brew install neovim
    # Install vim
    brew install vim
    setup_vim
}



install_tmux(){
    # Install tmux
    brew install tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

install_dev(){
     # Install golang
    brew install golang
}


install_tools(){
    sudo easy_install pip
    brew install npm

    # Install git
    brew install git
    # Install FZF
    brew install fzf
    $(brew --prefix)/opt/fzf/install

    # Install rg
    brew install ripgrep
    # Install clipboard
    brew install reattach-to-user-namespace
    # Install ccat
    brew install ccat
    # Install sed
    brew install gnu-sed 
    # Install coreutils
    brew install coreutils
    # Install watch
    brew install watch
    # awk - linux
    brew install gawk
    # Install fd
    brew install fd
    # gotop
    brew install gotop
    # ctags
    brew install ctags-exuberant
    # for fzf and cat
    sudo gem install coderay bundler
    # network 
    brew install mtr
    # install curl
    brew install curl
    # git diff 
    brew install diff-so-fancy
    # like cat , but faster and colorful
    brew install bat
    brew install highlight
    # replace ls
    brew install exa

    
}

install_dev_tools(){
    # ngrok 
    brew cask install ngrok
}



install_all(){
    install_brew
    install_tools
    install_nvim
    install_zsh
    install_tmux
    install_cask_app
}

install_cask_app(){
    brew cask install iterm2
    brew cask install docker
}

case $1 in
    "init" )
        install_all
        ;;
    "brew")
        install_brew
        ;;
    "zsh")
        install_zsh
        ;;
    "nvim")
        install_nvim
        ;;
    "tools")
        install_tools
        ;;
esac
