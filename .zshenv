export SHELL=/bin/zsh

which rustc >/dev/null && export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

hash chromium 2>/dev/null && export BROWSER="chromium"

export PAGER="less"
export LESS="-R"

export GREP_OPTIONS
GREPOPTIONS="--binary-files=without-match --directories=recurse --exclude=\*.tmp --exclude-dir=.svn --exclude-dir=.git --color=auto"

alias vi="vim"
alias emacs="vim"
export EDITOR="vim"
