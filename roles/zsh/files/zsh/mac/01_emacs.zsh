################################################################################
# emacs
################################################################################
function E(){
    if [[ 0 -eq `ps ax | grep emacs | grep daemon | wc -l` ]] then;
       ${BREW_HOME}/bin/emacs --daemon
    fi
       ${BREW_HOME}/bin/emacsclient -nw -t --alternate-editor /usr/local/bin/emacs $*;
}

function kill-emacs(){
    ${BREW_HOME}/bin/emacsclient -e "(kill-emacs)"
}

alias emacs='E'
alias emasc='E'
alias em='E'
alias e='E'
export EDITOR='emacs'
