################################################################################
# aliases
################################################################################
# 共通
alias del='rm -rf'
alias cp='cp -irf'
alias mv='mv -i'
alias ..='cd ..'
alias eng='LANG=C LANGUAGE=C LC_ALL=C'
alias zcompile='zcompile ~/.zshrc'

# ls
export LSCOLORS=DxGxcxdxCxegedabagacad
alias la='ls -aFG'
alias ls='ls -G'
alias ll='ls -lsahG'
alias sl='ls'

# less
export LESS='-g -i -M -R -S -W -z-4 -x4 -j10 --no-init --quit-if-one-screen'
export LESSCOLORIZER="/usr/local/bin/pygmentize"
export LESSCHARSET="utf-8"
export LESS_ADVANCED_PREPROCESSOR="1"
alias more='less'

# exit
alias q='exit'
alias quit='exit'

# vi
alias vi='vim'
alias v='vim'
