fpath=($HOME/dotfiles/fpath $fpath)

autoload -U compinit && compinit -u
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
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
setopt interactive_comments
setopt magic_equal_subst

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

if [ -d $HOME/dotfiles/fzf ]; then
    source $HOME/dotfiles/fzf/shell/completion.zsh
    source $HOME/dotfiles/fzf/shell/key-bindings.zsh
    if which ag > /dev/null 2>&1 ; then
        export FZF_DEFAULT_COMMAND='REPORTTIME='' ag --nocolor -g ""'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_DEFAULT_OPTS='
        --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
        --color info:108,prompt:109,spinner:108,pointer:168,marker:168
        '
    fi
fi

REPORTTIME=3

autoload -U colors && colors

function set-title() {
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
which nvim > /dev/null 2>&1 && alias vim="nvim"
alias ll="ls -l"
alias la="ls -a"
alias hd="hexdump -C"
alias mv="mv -i"
alias cp="cp -i"
alias unique="awk '!x[\$0]++'"
alias cg='cd-gitroot'
alias gdb='gdb -q'
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'"

alias beep="mplayer /opt/mikutter/core/skin/data/sounds/mikuxtu.wav > /dev/null 2>&1"
alias dispoff="xset dpms force standby"
alias hdmiout="xrandr --output HDMI1 --auto"
alias v4lload='LD_PRELOAD=/usr/lib/libv4l/v4l2convert.so'
alias httpserv="ruby -rsinatra -e 'set :bind, \"127.0.0.1\"; set :public_folder, \"./\"; get(\"/\"){\"Hello world\"}'"
alias httpserv-pub="ruby -rsinatra -e 'set :bind, \"0.0.0.0\"; set :public_folder, \"./\"; get(\"/\"){\"Hello world\"}'"

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

# OPAM configuration
. /home/cookies/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/.local/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
