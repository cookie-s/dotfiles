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
autoload -Uz git-escape-magic && git-escape-magic
eval "$(starship init zsh)"

REPORTTIME=3

autoload -U colors && colors

source $HOME/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
alias g++='g++ -Wall'
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'"

alias hdmiout="xrandr --output HDMI1 --auto"
alias v4lload='LD_PRELOAD=/usr/lib/libv4l/v4l2convert.so'
alias aslr-dis='echo 0 | sudo tee /proc/sys/kernel/randomize_va_space'
alias aslr-en='echo 2 | sudo tee /proc/sys/kernel/randomize_va_space'
alias recordscreen='wf-recorder -g "$(slurp)"'
alias ghidra="_JAVA_AWT_WM_NONREPARENTING=1 ghidra" # https://github.com/NationalSecurityAgency/ghidra/issues/44


alias k="kubectl"

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

function p() {
    if [[ $# -gt 0 ]]; then
        ps auxww | grep "$@"
    else
        ps aux
    fi
}

function g() {
    case ${OSTYPE} in
        darwin*)
            g++ -Wall -Wl,-stack_size -Wl,100000000 -std=c++2a -O3 "$@"
            ;;
        linux*)
            g++ a.cpp -O3 -Iac-library "$@"
            ;;
    esac
}

function ssh() {
  if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
    tmux rename-window -- "$1"
    command ssh "$@"
    tmux set-window-option automatic-rename on
  else
    command ssh "$@"
  fi
}

which pyenv >/dev/null 2>&1 && eval "$(pyenv init -)"

[ -d $HOME/.rvm/bin ] && export PATH="$PATH:$HOME/.rvm/bin"

export PATH="$HOME/.local/bin:$PATH"

[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] && source "$HOME/google-cloud-sdk/path.zsh.inc"
[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] && source "$HOME/google-cloud-sdk/completion.zsh.inc"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

[ -d "$HOME/.cargo/bin" ] && export PATH="$HOME/.cargo/bin:$PATH"

if [ -d $HOME/dotfiles/fzf ]; then
    source $HOME/dotfiles/fzf/shell/completion.zsh
    source $HOME/dotfiles/fzf/shell/key-bindings.zsh
fi

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
