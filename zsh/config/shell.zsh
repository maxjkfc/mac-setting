# tm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.
ftm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}


# fs [FUZZY PATTERN] - Select selected tmux session
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}

# ftpane - switch pane (@george-b)
ftpane() {
  local panes current_window current_pane target target_window target_pane
  panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
  current_pane=$(tmux display-message -p '#I:#P')
  current_window=$(tmux display-message -p '#I')

  target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

  target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
  target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

  if [[ $current_window -eq $target_window ]]; then
    tmux select-pane -t ${target_window}.${target_pane}
  else
    tmux select-pane -t ${target_window}.${target_pane} &&
    tmux select-window -t $target_window
  fi
}
# fbip - brew install by fzf
fbip() {
  local inst=$(brew search | fzf -m)

  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
  fi
}

# fbup - brew upgrade by fzf
fbup() {
    local upd=$(brew leaves | fzf -m)

    if [[ $upd ]]; then
      for prog in $(echo $upd);
      do; brew upgrade $prog; done;
    fi
}
# fbrm - brew remove by fzf
fbrm() {
  local uninst=$(brew leaves | fzf -m)

  if [[ $uninst ]]; then
    for prog in $(echo $uninst);
    do; brew uninstall $prog; done;
  fi
}


# gbr_fzf - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
gbr() {
    local branches branch
    branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
    branch=$(echo "$branches" |
             #fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
             fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}


# gco_fzf - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
gco() {
    local tags branches target
    branches=$(
        git --no-pager branch --all \
          --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
        | sed '/^$/d') || return
    tags=$(git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
    target=$(
        (echo "$branches"; echo "$tags") |
        fzf --no-hscroll --no-multi --delimiter="\t" -n 2 \
            --ansi --preview="git log -200 --pretty=format:%s $(echo {+2..} |  sed 's/$/../' )" ) || return
    git checkout  $(echo "$target" | awk '{print $2}')
}

alias glGraph='git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"

# gcop_fzf - checkout git commit with previews
gcop() {
  local commit
  commit=$( glGraph |
    fzf --no-sort --reverse --tiebreak=index --no-multi \
        --ansi --preview="$_viewGitLogLine" ) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}



#fshow - git commit browser with previews
gshow() {
    glGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
                --header "enter to view, alt-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | less -R" \
                --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}

# fpush - git push by fzf
gpush() {
    local tags branches target
    tags=$(
        git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
    branches=$(
        git branch --all | grep -v HEAD |
        sed "s/.* //" | sed "s#remotes/[^/]*/##" |
        sort -u | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
    target=$(
        (echo "$tags"; echo "$branches") |
        fzf --no-hscroll --no-multi --delimiter="\t" -n 2 \
            --ansi --preview="git log -200 --pretty=format:%s $(echo {+2..} |  sed 's/$/../' )" ) || return
    git push origin $(echo "$target" | awk '{print $2}')
}

gpull() {

    local tags branches target
    tags=$(
        git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
    branches=$(
        git branch --all | grep -v HEAD |
        sed "s/.* //" | sed "s#remotes/[^/]*/##" |
        sort -u | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
    target=$(
        (echo "$tags"; echo "$branches") |
        fzf --no-hscroll --no-multi --delimiter="\t" -n 2 \
            --ansi --preview="git log -200 --pretty=format:%s $(echo {+2..} |  sed 's/$/../' )" ) || return
    git pull origin $(echo "$target" | awk '{print $2}')
}

gmerge() {

    local tags branches target
    tags=$(
        git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
    branches=$(
        git branch --all | grep -v HEAD |
        sed "s/.* //" | sed "s#remotes/[^/]*/##" |
        sort -u | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
    target=$(
        (echo "$tags"; echo "$branches") |
        fzf --no-hscroll --no-multi --delimiter="\t" -n 2 \
            --ansi --preview="git log -200 --pretty=format:%s $(echo {+2..} |  sed 's/$/../' )" ) || return
    git merge --no-ff $(echo "$target" | awk '{print $2}')
}


# vg - vim and rg
vg() {
  local file
  file="$(rg --no-block-buffered --color=always --no-heading $@ | fzf -0 -1 | awk -F: '{print $1}')" 
  if [[ -n $file ]]; then
      ${EDITOR:-vim} "$file"
  fi
}

#fkll - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# fdim - docker rm image use fzf
fdim() {
  local id
  id=$(docker image ls |fzf -m | awk {'print$3'})
  docker image rm -f $id
}

# myip - show my ip
myip() {
    local_ip=$(ifconfig en0 |grep "inet\ " | awk {'print $2'})
    inter_ip=$(curl -s https://api.ipify.org)
    echo $fg[red]"Local:" $fg[white] $local_ip
    echo $fg[red]"Inter:" $fg[white] $inter_ip
}

# git

gct() {
    local tag=$1    
    local msg=$2


    if [[ -z $tag ]] then
        echo $fg[red]"The empty tag : $tag"
    fi

    if [[ -z $msg ]] then
        echo $fg[red]"The empty msg : $msg"
    fi


    git commit -m "$msg" 
    git tag -a $tag -m "$msg"

    git push origin master $tag

}


