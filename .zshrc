ZSH_THEME="garyblessington"

export ZSH="$HOME/.oh-my-zsh"
export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"
plugins=( 
	git
	extract
)
setopt extendedglob

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh


alias l="ls -a"
alias mkdir="mkdir -p"
alias q="exit"
alias :q="exit"
alias c="cd"
alias c.="cd $HOME/code/dots/"
alias cc="cd $HOME/code/"
alias cs="cd $HOME/code/drafts/"
alias so.="source $HOME/.zshrc"
alias vi="nvim"
alias env="nvim .env"
alias venv="source venv/bin/activate"
alias unzip="extract"
alias off="shutdown now"

bindkey '^[^[[D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
# For Control k and j
bindkey '^k' up-line-or-history
bindkey '^j' down-line-or-history
bindkey '^l' autosuggest-accept
bindkey '^p' clear-screen
bindkey '^H' backward-delete-word

if [ -f $HOME/.ico/ico.sh ]; then
  source $HOME/.ico/ico.sh
fi

if [ -f $HOME/.secrets.sh ]; then
  source $HOME/.secrets.sh
fi
