export PATH=$PATH:$HOME/path
export PATH=$PATH:/usr/local/bin
# export PATH=$PATH:/usr/local/heroku/bin
export SHELL=/bin/zsh

hash chromium 2>/dev/null && export BROWSER="chromium"

export PAGER="less"
export LESS="-R"

export GREP_OPTIONS
GREPOPTIONS="--binary-files=without-match --directories=recurse --exclude=\*.tmp --exclude-dir=.svn --exclude-dir=.git --color=auto"

alias vi="vim"
alias emacs="vim"
export EDITOR="vim"
