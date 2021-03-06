# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='fd  --type file --hidden --follow  --exclude .git' 

#export FZF_DEFAULT_OPTS=' --height 40% --layout=reverse --border --ansi
                          #--color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
                          #--color info:150,prompt:110,spinner:150,pointer:167,marker:174'
export FZF_DEFAULT_OPTS=' --height 40% --layout=reverse --border --ansi
                          --color fg:-1,bg:-1,hl:230,fg+:3,bg+:-1,hl+:229
                          --color info:150,prompt:110,spinner:150,pointer:167,marker:174'
                          
export FZF_CTRL_T_OPTS='--preview "[[ $(file --mime {}) =~ binary ]] &&
                  echo {} is a binary file ||
                  (bat --style=numbers --color=always {} ||
                  highlight -O ansi -l {} ||
                  coderay {} ||
                  rougify {} ||
                  cat {}) 2> /dev/null | head -500"'

export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

export FZF_TMUX=1
export FZF_TMUX_HEIGHT=40

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

#export FZF_COMPLETION_TRIGGER=''
#bindkey '^T' fzf-completion
#bindkey '^I' $fzf_default_completion
