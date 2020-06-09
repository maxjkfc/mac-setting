#/bin/bash


install_brew(){
    echo "Install Ruby Brew ..."
if  hash brew 2>/dev/null; then
    echo "brew is installed"
else
     #Install Brew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

}


install_zsh() {
    echo "Install Zsh ...."
    # zsh
    brew install zsh     
    chsh -s /bin/zsh
    
    # Install zsh plug 
    brew install zplug
}

setup_zsh_completions_docker-compose() {
    mkdir -p ~/.zsh/completion
    curl -L https://raw.githubusercontent.com/docker/compose/1.24.0/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose
}




install_tmux(){
    # Install tmux
    brew install tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}



install_tools(){
    # Install golang
    brew install golang
    # Install neovim
    brew install neovim
    # Install vim
    brew install vim --lua
    # install git
    brew install git
    # install lazygit
    brew install lazygit
    # Install FZF
    brew install fzf
    # Install rg
    brew install ripgrep
    # Install clipboard
    brew install reattach-to-user-namespace
    # Install ccat
    brew install ccat
    # Install sed
    brew install gnu-sed --with-default-name
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



run_shell(){
    # run shell to setup zsh
    sh setup-zsh.sh
    # run shell to setup nvim
    sh setup-vim.sh nvim
}

install_all(){
    install_brew
    install_zsh
    install_tmux
    install_tools
    install_app
}

install_app(){
    brew cask install iterm2
}

case $1 in
    "init" )
        install_all
        run_shell
        ;;
    "brew")
        install_brew
        ;;
    "zsh")
        install_zsh
        ;;
    "tools")
        install_tools
        ;;
esac
