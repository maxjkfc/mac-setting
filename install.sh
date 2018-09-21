#/bin/bash



# Install Brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


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

# Fonts
brew tap caskroom/fonts
brew cask install font-hack-nerd-font

