[ -f "$HOME"/.work/init.sh ] && source "$HOME"/.work/init.sh
[ -f "$HOME"/.secrets.sh ] && source "$HOME"/.secrets.sh

[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/go/bin" ] && PATH="$HOME/go/bin:$PATH"
[ -d "$HOME/.cargo/bin" ] && PATH="$HOME/.cargo/bin:$PATH"
[ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ] && PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"
[ -d "$HOME/.yarn/bin" ] && PATH="$HOME/.yarn/bin:$PATH";

export PATH=$PATH
export NOTES="$HOME/.sync/notes/"
export CODE="$HOME/code/"
export DOTS="$HOME/code/dots/"
export EDITOR=nvim

export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
