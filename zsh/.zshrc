# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ $TMUX = "" ]] && export TERM="xterm-256color"
ZSH_THEME="powerlevel10k"
# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

HIST_STAMPS="yyyy-mm-dd"

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

test -e "${myzshconfig}/.zshrc.path"       && source "${myzshconfig}/.zshrc.path"
test -e "${myzshconfig}/.zshrc.alias"      && source "${myzshconfig}/.zshrc.alias"
test -e "${myzshconfig}/.zshrc.plugin"     && source "${myzshconfig}/.zshrc.plugin"
test -e "${myzshconfig}/.zshrc.shell"      && source "${myzshconfig}/.zshrc.shell"
test -e "${myzshconfig}/.zshrc.fzf"        && source "${myzshconfig}/.zshrc.fzf"
test -e "${myzshconfig}/.zshrc.gcp"        && source "${myzshconfig}/.zshrc.gcp"
test -e "${myzshconfig}/.zshrc.iterm2"     && source "${myzshconfig}/.zshrc.iterm2"
test -e "${myzshconfig}/.zshrc.theme"      && source "${myzshconfig}/.zshrc.theme"
test -e "${myzshconfig}/.zshrc.zplug"      && source "${myzshconfig}/.zshrc.zplug"
test -e "${myzshconfig}/.zshrc.kubectl"    && source "${myzshconfig}/.zshrc.kubectl"
test -e "${myzshconfig}/.zshrc.completion" && source "${myzshconfig}/.zshrc.completion"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"



# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/maxjkfc/workplace/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/maxjkfc/workplace/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/maxjkfc/workplace/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/maxjkfc/workplace/google-cloud-sdk/completion.zsh.inc'; fi
