[ -f $HOME/.ico/ico.sh ] && source $HOME/.ico/ico.sh
[ -f $HOME/.secrets.sh ] && source $HOME/.secrets.sh

[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ] && PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"

export PATH=$PATH
export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
export EDITOR=nvim
