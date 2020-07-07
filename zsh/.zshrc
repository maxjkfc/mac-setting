# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_DISABLE_COMPFIX="true"

[[ $TMUX = "" ]] && export TERM="xterm-256color"

ZSH_THEME="powerlevel10k"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
# 
export EDITOR='nvim'

# set the shell 
set -o emacs


#artii $(date +%Y-%m-%d\ %H:%M:%S)

echo $fg[blue]
#echo    '--------------------------------------------------------------------------------------------'
echo    '    █████╗ ██╗  ██╗ ██████╗ ██╗      ██████╗ ████████╗██╗        ███╗   ███╗ █████╗ ██╗  ██╗'
echo    '   ██╔══██╗╚██╗██╔╝██╔═══██╗██║     ██╔═══██╗╚══██╔══╝██║        ████╗ ████║██╔══██╗╚██╗██╔╝'
echo    '   ███████║ ╚███╔╝ ██║   ██║██║     ██║   ██║   ██║   ██║        ██╔████╔██║███████║ ╚███╔╝ '
echo    '   ██╔══██║ ██╔██╗ ██║   ██║██║     ██║   ██║   ██║   ██║        ██║╚██╔╝██║██╔══██║ ██╔██╗ '
echo    '   ██║  ██║██╔╝ ██╗╚██████╔╝███████╗╚██████╔╝   ██║   ███████╗██╗██║ ╚═╝ ██║██║  ██║██╔╝ ██╗'
echo    '   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝ ╚═════╝    ╚═╝   ╚══════╝╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝'
#echo    '--------------------------------------------------------------------------------------------'
#screenfetch -E

# User configuration
#source ~/.bash_profile

export myzshconfig="$HOME/.zsh/config"
export HISTSIZE=1000

test -e "${myzshconfig}/path.zsh"       && source "${myzshconfig}/path.zsh"
test -e "${myzshconfig}/alias.zsh"      && source "${myzshconfig}/alias.zsh"
test -e "${myzshconfig}/plugin.zsh"     && source "${myzshconfig}/plugin.zsh"
test -e "${myzshconfig}/shell.zsh"      && source "${myzshconfig}/shell.zsh"
test -e "${myzshconfig}/fzf.zsh"        && source "${myzshconfig}/fzf.zsh"
test -e "${myzshconfig}/gcp.zsh"        && source "${myzshconfig}/gcp.zsh"
test -e "${myzshconfig}/iterm2.zsh"     && source "${myzshconfig}/iterm2.zsh"
test -e "${myzshconfig}/theme.zsh"      && source "${myzshconfig}/theme.zsh"
test -e "${myzshconfig}/zplug.zsh"      && source "${myzshconfig}/zplug.zsh"
test -e "${myzshconfig}/kubectl.zsh"    && source "${myzshconfig}/kubectl.zsh"
test -e "${myzshconfig}/completion.zsh" && source "${myzshconfig}/completion.zsh"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/maxjkfc/Documents/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/maxjkfc/Documents/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/maxjkfc/Documents/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/maxjkfc/Documents/google-cloud-sdk/completion.zsh.inc'; fi
