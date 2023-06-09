[ -f $HOME/.ico/ico.sh ] && source $HOME/.ico/ico.sh
[ -f $HOME/.secrets.sh ] && source $HOME/.secrets.sh

[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ] && PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"
# [ -d "$HOME/.tmuxifier/bin" ] && PATH="$HOME/.tmuxifier/bin:$PATH"; eval "$(tmuxifier init -)"
[ -d "$HOME/.tmuxifier/bin" ] && PATH="$HOME/.tmuxifier/bin:$PATH"; eval "$(tmuxifier init -)"

export PATH=$PATH
export EDITOR=nvim

export TMUXIFIER_LAYOUT_PATH="$HOME/.tmux-layouts"
export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
