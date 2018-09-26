#/bin/bash



# Install Brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# zsh
brew install zsh zsh-completions

chsh -s /bin/zsh

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


# Install tmux
brew install tmux

# Install FZF
brew install fzf

# Install rg
brew install ripgrep

# Install clipboard
brew install reattach-to-user-namespace

# Install neovim
brew install neovim

# Install vim
#brew install vim


# Fonts
brew tap caskroom/fonts
brew cask install font-hack-nerd-font

