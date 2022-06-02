export SHELL=/bin/zsh

which chromium >/dev/null && export BROWSER="chromium"

export PAGER="less"
export LESS="-R"

export GREPOPTIONS="--binary-files=without-match --directories=recurse --exclude=\*.tmp --exclude-dir=.svn --exclude-dir=.git --color=auto"

[ -z "$EDITOR" ] && export EDITOR="vim"
alias vi=$EDITOR
alias vim=$EDITOR
alias emacs=$EDITOR

export GOHOME=$HOME/go

export CLOUDSDK_PYTHON=python3
