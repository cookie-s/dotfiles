fpath=($HOME/dotfiles/fpath $fpath)

autoload -U compinit
compinit -u
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
#zstyle ':completion:*:default' list-colors ""
#zstyle ':completion:*:default' menu select=3
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'
zstyle ':completion:*' use-cache yes
setopt complete_in_word

HISTFILE=~/.zsh_history
HISTSIZE=1000000000
SAVEHIST=1000000000
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

setopt auto_pushd
setopt list_packed
setopt no_beep
setopt nolistbeep
setopt hist_expand
setopt numeric_glob_sort
setopt extended_glob

setopt inc_append_history
setopt no_flow_control

setopt prompt_subst
setopt prompt_percent
setopt transient_rprompt

setopt long_list_jobs

autoload -Uz cd-gitroot
autoload -U promptinit && promptinit
PURE_GIT_PULL=0
PURE_PROMPT_SYMBOL='>>'
prompt pure

REPORTTIME=3

setopt ignore_eof

autoload -U colors
colors
setopt re_match_pcre

#PROMPT="%(?..%{${bg[blue]}%})[%n@%m]%#%{${reset_color}%} "
#RPROMPT="%~"
#PROMPT2="%_%% "
#if [ ${UID} = 0 ]; then
#    PROMPT="\B\e[31m${PROMPT}\e[m%b"
#    PROMPT2="\B\e[31m${PROMPT2}\e[m%b"
#    SPROMPT="\B\e[31m${SPROMPT}\e[m%b"
#fi
#if [ -n "${REMOTEHOST}${SSH_CONNECTION}" ]; then
#    PROMPT="[R]${PROMPT}"
#fi


set-title() {
    print "\e]0;$1\a"
}

export LANG=ja_JP.UTF-8

bindkey -v
alias ls="ls --color=auto -F"
alias l="ls"
alias ll="ls -l"
alias la="ls -a"
alias hd="hexdump -C"
alias mv="mv -i"
alias cp="cp -i"
alias unique="awk '!x[\$0]++'"
alias cg='cd-gitroot'

alias beep="mplayer -ao jack /opt/mikutter/core/skin/data/sounds/mikuxtu.wav > /dev/null 2>&1"
alias v4lload='LD_PRELOAD=/usr/lib/libv4l/v4l2convert.so'

alias -s html=chromium
alias -s xhtml=chromium
alias -s gif=feh
alias -s jpg=feh
alias -s jpeg=feh
alias -s png=feh
alias -s bmp=feh
alias -s mp3=mplayer
alias -s m4a=mplayer
alias -s ogg=mplayer
alias -s mp4=mplayer
alias -s mpg=mplayer
alias -s mpeg=mplayer
alias -s flv=mplayer
alias -s avi=mplayer

