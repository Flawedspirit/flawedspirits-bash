#!/bin/sh -e

RESET='\E[0m'
RED='\E[38;5;124m'
YELLOW='\E[38;5;221m'
GREEN='\E[38;5;34m'
BLUE='\E[38;5;33m'

# Check if home directory and fsbashtools folder exists; create them if they don't
BASHTOOLSFOLDER="$HOME/.bashtools"

if [ ! -d "$BASHTOOLSFOLDER" ]; then
    echo "${BLUE}Creating FS Bash tools directory: $BASHTOOLSFOLDER${RESET}"
    mkdir -p $BASHTOOLSFOLDER
    echo "${GREEN}Created FS Bash tools directory${RESET}"
fi

# Add variables to top level so can easily be accessed by all functions
PACKAGER=""
SUDO_CMD=""
SUGROUP=""
GITPATH=""

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

checkEnv() {
    # Check for basic requirements
    REQS='curl groups sudo'

    for req in $REQS; do
        if ! command_exists "$req"; then
            echo "${RED}To run this script, you need: $REQS${RESET}"
            exit 1
        fi
    done

    # Check package manager
    PACKAGEMANAGER='nala apt dnf yum pacman zypper emerge xbps-install nix-env'
    for pgm in $PACKAGEMANAGER; do
        if command_exists "$pgm"; then
            PACKAGER="$pgm"
            echo "Using $PACKAGER as package manager."
            break
        fi
    done

    if [ -z "$PACKAGER" ]; then
        echo "${RED}Can't find a supported package manager.${RESET}"
        exit 1
    fi

    if command_exists sudo; then
        SUDO_CMD="sudo"
    elif command_exists doas && [ -f "/etc/doas.conf" ]; then
        SUDO_CMD="doas"
    else
        SUDO_CMD="su -c"
    fi

    echo "Using $SUDO_CMD to do privilege escalation."
}

checkEnv
