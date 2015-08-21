# Path to your oh-my-zsh installation.
export ZSH=/home/bbg/.oh-my-zsh
ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[white]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}●%{$fg[white]%}]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="]%{$reset_color%} "
ZSH_THEME_SVN_PROMPT_PREFIX=$ZSH_THEME_GIT_PROMPT_PREFIX
ZSH_THEME_SVN_PROMPT_SUFFIX=$ZSH_THEME_GIT_PROMPT_SUFFIX
ZSH_THEME_SVN_PROMPT_DIRTY=$ZSH_THEME_GIT_PROMPT_DIRTY
ZSH_THEME_SVN_PROMPT_CLEAN=$ZSH_THEME_GIT_PROMPT_CLEAN
ZSH_THEME_HG_PROMPT_PREFIX=$ZSH_THEME_GIT_PROMPT_PREFIX
ZSH_THEME_HG_PROMPT_SUFFIX=$ZSH_THEME_GIT_PROMPT_SUFFIX
ZSH_THEME_HG_PROMPT_DIRTY=$ZSH_THEME_GIT_PROMPT_DIRTY
ZSH_THEME_HG_PROMPT_CLEAN=$ZSH_THEME_GIT_PROMPT_CLEAN
red=%{$'\e[0;31m'%}
purple=%{$'\e[0;35m'%}

vcs_status() {
        git_prompt_info
}

PROMPT='${purple}>>${red} %2~ $(vcs_status)%b '
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
