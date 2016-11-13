################################################################################
# Java系
################################################################################
export JAVA_HOME="$(/usr/libexec/java_home)"
# for gradle and groovy
load-if-exists "${HOME}/.gvm/bin/gvm-init.sh"
## gradle
export GRADLE_HOME="${HOME}/.gvm/gradle/current"
export PATH="${HOME}/.gvm/gradle/current/bin:$PATH"
export JAVA_OPTS=-Dfile.encoding=UTF-8
export GRADLE_OPTS=-Xmx1024m
alias g=gradle
## groovy
export GROOVY_HOME="${HOME}/.gvm/groovy/current"

###############################################################################
# Python
################################################################################
function pip_init(){
    pip install -U ansible pygments virtualenvwrapper flake8 ipython
}

################################################################################
# node
################################################################################
alias npm-exec=`export PATH=$(npm bin):${PATH}`

function npm_all_update(){
    npm update -g
    npm dedupe
    [ -e ${BREW_HOME}/bin/npm-check-updates ] && npm-check-updates
    npm update -u
    npm cache clean
    rm ${HOME}/.npm
}
