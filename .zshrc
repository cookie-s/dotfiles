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
PURE_PROMPT_SYMBOL='>>'
PURE_GIT_DOWN_ARROW='v'
PURE_GIT_UP_ARROW='^'
prompt pure
autoload -Uz git-escape-magic && git-escape-magic

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

bindkey -v
case "$OSTYPE" in
    darwin*)
        alias ls="ls -G -F"
        ;;
    linux*)
        alias ls="ls --color=auto -F"
        ;;
esac
which nvim > /dev/null && alias vim="nvim"
alias ll="ls -l"
alias la="ls -a"
alias hd="hexdump -C"
alias mv="mv -i"
alias cp="cp -i"
alias unique="awk '!x[\$0]++'"
alias cg='cd-gitroot'
alias gpp='g++'
alias gdb='gdb -q'
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'"
alias c-='cd -'

alias beep="mplayer /opt/mikutter/core/skin/data/sounds/mikuxtu.wav > /dev/null 2>&1"
alias dispoff="xset dpms force standby"
alias hdmiout="xrandr --output HDMI1 --auto"
alias v4lload='LD_PRELOAD=/usr/lib/libv4l/v4l2convert.so'
alias httpserv="ruby -rsinatra -e 'set :public_folder, \"./\", get(\"/\"){\"Hello world\"}'"

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

function l() {
    if [[ ($# -eq 1 && -f "$1") || (-p /dev/stdin) ]]; then
        less "$@"
    else
        ls -alF --color=auto "$@"
    fi
}

function p() {
    if [[ $# -gt 0 ]]; then
        ps auxww | grep "$@"
    else
        ps aux
    fi
}

function h() {
    if [[ $# -gt 0 ]]; then
        history | tac | sort -k2 -u | sort | grep "$@"
    else
        history 50
    fi
}

function grt() {
    git rev-parse --show-toplevel
}

source $HOME/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# OPAM configuration
. /home/cookies/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
