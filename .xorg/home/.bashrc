#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias vi="nvim"
alias vim="nvim"
alias cat="bat"
alias ls="eza -la --git --icons --group-directories-first --time-style=long-iso --classify"
alias cdgit='cd $(git rev-parse --show-toplevel)'
alias nano="nvim" # suck it

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# alternative tools
alias dig="drill"

alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
