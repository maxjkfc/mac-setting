#!/bin/bash
set -e

setup_tmux() {
	echo "setup [tmux] config"

	if [ -f "$HOME/.tmux.conf" ]; then
		rm -rf $HOME/.tmux.conf
	fi

	ln -s $PWD/tmux/.tmux.conf $HOME/.tmux.conf

	# TODO check tpm install?
	echo "setup tmux config finish"

	# TODO reload tmux and install plugin
}

setup_zsh() {
	echo "setup [zsh] config"

	if [ -f "$HOME/.zshrc" ]; then
		rm -rf $HOME/.zshrc
	fi

	ln -s $PWD/zsh/.zshrc $HOME/.zshrc

	if [ -f "$HOME/.zshshell" ]; then
		rm -rf $HOME/.zshshell
	fi

	ln -s $PWD/zsh/.zshshell $HOME/.zshshell
	

	# TODO check zsh install?
	echo "setup [zsh] config finish"
}


case $1 in 
	"tmux") 
		setup_tmux
		;;
	"zsh") 
		setup_zsh
		;;
	*)
		echo "not match any pkg"
		exit
		;;
esac
