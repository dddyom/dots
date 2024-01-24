alias l="ls -a"
alias mkdir="mkdir -p"
alias q="exit"
alias :q="exit"
alias c="cd"
alias c.="cd $HOME/code/dots/ && clear"
alias cc="cd $HOME/code/ && clear"
alias so.="source $HOME/.zshrc"
alias v="nvim"
alias vi="nvim"
alias env="nvim .env"
alias venv="source venv/bin/activate"
alias off="shutdown now"
alias t="tmuxifier"
alias merge="git mergetool"

tmuxifier list-sessions | while read -r session; do
    cmd_string=$(printf "alias %s='tmuxifier load-session %s'" "$session" "$session")
    eval $cmd_string
done

