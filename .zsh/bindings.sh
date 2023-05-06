bindkey '^P' backward-word
bindkey '^N' forward-word
bindkey '^B' beginning-of-line
bindkey '^E' end-of-line
bindkey '^H' backward-delete-word

bindkey '^K' up-line-or-history
bindkey '^J' down-line-or-history

bindkey '^A' autosuggest-accept

bindkey -s '^W' 'file=$(find $HOME | fzf) ; [[ ! -z $file ]] && nvim $file^M'
bindkey -s '^T' 'tmuxifier run^M'
