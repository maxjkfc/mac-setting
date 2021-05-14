#zplug 
source $ZPLUG_HOME/init.zsh
setopt prompt_subst # Make sure prompt is able to be generated properly.

#zplug "romkatv/powerlevel10k", use:powerlevel10k.zsh-theme
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "b4b4r07/enhancd", use:init.sh

#zplug "plugins/docker" , from:oh-my-zsh 
#zplug "plugins/golang" , from:oh-my-zsh 
#zplug "plugins/docker-compose" , from:oh-my-zsh 
# 
zplug "wfxr/forgit"

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"

#
zplug "supercrabtree/k"

zplug "~/.zsh", from:local

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

autoload -Uz compinit && compinit -i
