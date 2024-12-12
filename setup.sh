#!/bin/bash
set -e

setup_install_depend() {

	if ! command -v zplug &>/dev/null; then
		brew install zplug
	fi

	brew install eza
	brew install bat
	brew install powerlevel10k
	brew install ripgrep
	brew install fzf
	brew install wget
	brew install gnu-sed
	brew install git
	brew install fd
	brew install tmux
	brew install curl
	brew install reattach-to-user-namespace
}

setup_tmux() {
	echo "setup [tmux] config"

	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

	if [ -f "$HOME/.tmux.conf" ]; then
		rm -rf "$HOME"/.tmux.conf
	fi

	ln -s "$PWD"/tmux/.tmux.conf "$HOME"/.tmux.conf

	echo "setup tmux config finish"

}

setup_zsh() {
	echo "setup [zsh] config"

	if [ -f "$HOME/.zshrc" ]; then
		rm -rf "$HOME"/.zshrc
	fi

	ln -s "$PWD"/zsh/.zshrc "$HOME"/.zshrc

	if [ -f "$HOME/.zshshell" ]; then
		rm -rf "$HOME"/.zshshell
	fi

	ln -s "$PWD"/zsh/.zshshell "$HOME"/.zshshell

	if [ -f "$HOME/.zprofile" ]; then
		rm -rf "$HOME"/.zprofile
	fi

	ln -s "$PWD"/zsh/.zprofile "$HOME"/.zprofile

	setup_install_depend

	echo "setup [zsh] config finish"
}

setup_nvim() {
	echo "setup [nvim] config"
	NVIM_PATH="$HOME/.config"

	if [ -d "$NVIM_PATH/nvim" ]; then
		rm -rf $NVIM_PATH/nvim
	fi

	ln -s "$PWD"/nvim "$NVIM_PATH"/nvim

	echo "setup [nvim] config finish"

	# install depand plugins
}

case $1 in
"tmux")
	setup_tmux
	;;
"zsh")
	setup_zsh
	;;
"nvim")
	setup_nvim
	;;
*)
	echo "not match any pkg"
	exit
	;;
esac
