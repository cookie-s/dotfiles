export PATH=$PATH:$HOME/path
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.config/composer/vendor/bin
[[ -d "$HOME/go/bin" ]] && export PATH=$PATH:$HOME/go/bin
[[ -d '/usr/local/heroku' ]] && export PATH=$PATH:/usr/local/heroku/bin
[[ -d "$HOME/google-cloud-sdk/platform/google_appengine/" ]] && export PATH=$PATH:"$HOME/google-cloud-sdk/platform/google_appengine"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
