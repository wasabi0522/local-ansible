################################################################################
# brew
################################################################################
BREW_HOME="/usr/local"
export-if-exists PATH ${BREW_HOME}/bin
export-if-exists PATH ${BREW_HOME}/sbin
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# brew management
function brew_all_update () {
    BREW=${BREW_HOME}/bin/brew
    ${BREW} update
    ${BREW} doctor
    ${BREW} upgrade
    ${BREW} cleanup --force
    ${BREW} cask doctor
    ${BREW} cask update
    ${BREW} cask cleanup
    echo "Finshed brew cask all update"
}

alias repair='diskutil repairPermissions /'

# tmuxがC-hを奪わないように
if [[ "${TERM}" = "screen-256color" ]]; then
    stty erase "^?"
fi
