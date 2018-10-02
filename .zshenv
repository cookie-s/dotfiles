[ -f ~/.zshenv.local ] && source ~/.zshenv.local

export SHELL=/bin/zsh

which rustc >/dev/null && export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

which chromium >/dev/null && export BROWSER="chromium"

export PAGER="less"
export LESS="-R"

export GREPOPTIONS="--binary-files=without-match --directories=recurse --exclude=\*.tmp --exclude-dir=.svn --exclude-dir=.git --color=auto"

[ -z "$EDITOR" ] && export EDITOR="vim"
alias vi=$EDITOR
alias vim=$EDITOR
alias emacs=$EDITOR

export GOHOME=$HOME/go
