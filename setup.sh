#!/bin/bash

set -e


setup_tmux() {

	
	echo "setup tmux config"

	if [ -f "$HOME/.tmux.conf" ]; then
		rm -rf $HOME/.tmux.conf
	fi

	ln -s $PWD/tmux/.tmux.conf $HOME/.tmux.conf

	# TODO check tpm install?
	echo "setup tmux config finish"
}


case $1 in 
	"tmux") 
		setup_tmux
		;;
	*)
		echo "not match any pkg"
		exit
		;;
esac
