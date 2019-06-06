#export TERM=xterm-256color
[[ $TMUX = "" ]] && export TERM="xterm-256color"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="mymuse"
ZSH_THEME="bullet-train"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
#alias zshconfig="vim ~/.zshrc"
#alias ohmyzsh="vim ~/.oh-my-zsh"

#artii $(date +%Y-%m-%d\ %H:%M:%S)

echo $fg[blue]
echo    '    █████╗ ██╗  ██╗ ██████╗ ██╗      ██████╗ ████████╗██╗        ███╗   ███╗ █████╗ ██╗  ██╗'
echo    '   ██╔══██╗╚██╗██╔╝██╔═══██╗██║     ██╔═══██╗╚══██╔══╝██║        ████╗ ████║██╔══██╗╚██╗██╔╝'
echo    '   ███████║ ╚███╔╝ ██║   ██║██║     ██║   ██║   ██║   ██║        ██╔████╔██║███████║ ╚███╔╝ '
echo    '   ██╔══██║ ██╔██╗ ██║   ██║██║     ██║   ██║   ██║   ██║        ██║╚██╔╝██║██╔══██║ ██╔██╗ '
echo    '   ██║  ██║██╔╝ ██╗╚██████╔╝███████╗╚██████╔╝   ██║   ███████╗██╗██║ ╚═╝ ██║██║  ██║██╔╝ ██╗'
echo    '   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝ ╚═════╝    ╚═╝   ╚══════╝╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝'

#screenfetch -E

# User configuration
#source ~/.bash_profile

export myzshconfig="$HOME/.zsh/config"

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



# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/maxjkfc/workplace/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/maxjkfc/workplace/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/maxjkfc/workplace/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/maxjkfc/workplace/google-cloud-sdk/completion.zsh.inc'; fi
