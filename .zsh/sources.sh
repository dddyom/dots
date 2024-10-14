[ -f "$HOME"/.work/init.sh ] && source "$HOME"/.work/init.sh
[ -f "$HOME"/.secrets.sh ] && source "$HOME"/.secrets.sh

[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/go/bin" ] && PATH="$HOME/go/bin:$PATH"
[ -d "$HOME/.cargo/bin" ] && PATH="$HOME/.cargo/bin:$PATH"
[ -d "$HOME/.npm-packages/bin" ] && PATH="$HOME/.npm-packages/bin:$PATH"
[ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ] && PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"
[ -d "$HOME/.yarn/bin" ] && PATH="$HOME/.yarn/bin:$PATH";
[ -d "$HOME/Android/flutter/bin" ] && PATH="$HOME/Android/flutter/bin:$PATH";
[ -d "$HOME/.pub-cache/bin" ] && PATH="$HOME/.pub-cache/bin:$PATH";

export PATH=$PATH
export NOTES="$HOME/.sync/notes/"
export CODE="$HOME/code/"
export STATIC="$HOME/static/"
export DOTS="$HOME/code/dots/"
export EDITOR=nvim

export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_TOOLS="$HOME/Android/Sdk/cmdline-tools/latest"
export ANDROID_PLATFORM_TOOLS="$HOME/Android/Sdk/platform-tools"
PATH="$PATH:$ANDROID_HOME:$ANDROID_TOOLS:$ANDROID_PLATFORM_TOOLS"
export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable

export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH" && eval "$(pyenv init -)"
