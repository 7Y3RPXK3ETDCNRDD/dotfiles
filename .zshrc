# Path to your oh-my-zsh installation.
export ZSH=/home/bbg/.oh-my-zsh
ZSH_THEME="minimal"
plugins=(git vi-mode archlinux)
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
source $ZSH/oh-my-zsh.sh

autoload -Uz compinit
compinit

# Preferred editor for local and remote sessions
export EDITOR='vim'
# Get rid of ESC latency
export KEYTIMEOUT=1

# Aliases
ls='ls --color=always'
grep='grep --color=always'

alias pacman='sudo pacman -S'
alias update='sudo pacman -Syu'
alias size='du -h --max-depth=1'

alias g++='g++ -std=c++11 -Wall -Wextra'
alias clang++='clang++ -std=c++11 -Wall -Wextra'

alias ..='cd ..'
alias gocode='cd ~/CODE/c++/'
alias gofilm='cd ~/Videos/FILMZ'
alias govid='cd ~/Videos'
alias gopic='cd ~/Pictures'

alias shutdown='sudo shutdown now'
alias reboot='sudo reboot'
