autoload -U compinit
compinit
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
#zstyle ':completion:*:default' menu select=3
#zstyle ':completion:*:default' list-colors ""
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'
zstyle ':completion:*' use-cache yes
setopt complete_in_word
setopt hist_expand
setopt no_beep
setopt numeric_glob_sort
setopt extended_glob


bindkey -v

setopt auto_cd

HISTFILE=~/.zsh_history
HISTSIZE=1000000000
SAVEHIST=1000000000
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

setopt inc_append_history
setopt no_flow_control

setopt prompt_subst
setopt prompt_percent
setopt transient_rprompt

setopt long_list_jobs

REPORTTIME=3

setopt ignore_eof

autoload -U colors
colors
setopt re_match_pcre
PROMPT="%(?..%{${bg[blue]}%})[%n@%m]%#%{${reset_color}%} "
RPROMPT="%~"
PROMPT2="%_%% "
case ${UID} in
    0)
        PROMPT="\B\e[31m${PROMPT}\e[m%b"
        PROMPT2="\B\e[31m${PROMPT2}\e[m%b"
        SPROMPT="\B\e[31m${SPROMPT}\e[m%b"
esac

alias beep="mplayer -ao jack /opt/mikutter/core/skin/data/sounds/mikuxtu.wav > /dev/null 2>&1"

alias v4lload='LD_PRELOAD=/usr/lib/libv4l/v4l2convert.so'

set-title() {
    print "\e]0;$1\a"
}

export LANG=ja_JP.UTF-8

alias ls="ls --color=auto -F"
alias ll="ls -l"
alias la="ls -a"
alias l="ls"
alias hd="hexdump -C"
alias mv="mv -i"
alias cp="cp -i"
alias m="mikutter"

alias dispoff="xset dpms force off"

# source $HOME/.rvm/scripts/rvm
