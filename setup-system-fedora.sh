#!/bin/bash
RESET='\E[0m'
RED='\E[38;5;124m'
#YELLOW='\E[38;5;221m'
GREEN='\E[38;5;34m'
BLUE='\E[38;5;33m'

SUDO_CMD=""

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

checkEnv() {
    # Check for basic requirements
    REQS='curl groups sudo'

    for req in $REQS; do
        if ! command_exists "$req"; then
            echo -e "${RED}To run this script, you need: $REQS${RESET}"
            exit 1
        fi
    done

    # Check how we can escalate privileges
    if command_exists sudo; then
        SUDO_CMD="sudo"
    elif command_exists doas && [ -f "/etc/doas.conf" ]; then
        SUDO_CMD="doas"
    else
        SUDO_CMD="su -c"
    fi
    echo -e "Using ${BLUE}$SUDO_CMD${RESET} to do privilege escalation."
}

###############################################
# CONFIGURE PACKAGES                          #
###############################################

installPackages() {
    echo "Importing keys..."
    # VS Code
    $SUDO_CMD rpm --import https://packages.microsoft.com/keys/microsoft.asc
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | $SUDO_CMD tee /etc/yum.repos.d/vscode.repo >/dev/null

    # Brave Browser
    $SUDO_CMD dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
    $SUDO_CMD rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

    # Install packages needed for virtualization
    echo "Enabling virtualization..."
    $SUDO_CMD dnf groupinstall -y --with-optional virtualization
    $SUDO_CMD start libvirtd
    $SUDO_CMD enable libvirtd

    # Install packages with no further processing needed
    echo "Installing base packages..."
    $SUDO_CMD dnf check-update
    $SUDO_CMD dnf groupinstall -y development-tools
    $SUDO_CMD dnf install -y \
        arc \
        bash-completion \
        bat \
        brave-browser \
        btop \
        cabextract \
        cmake \
        code \
        discord \
        eza \
        fail2ban \
        fastfetch \
        filezilla \
        fzf \
        gcc-c++ \
        htop \
        input-remapper \
        java-17-openjdk \
        java-21-openjdk \
        kid3 \
        kio-gdrive \
        krita \
        make \
        nasm \
        net-tools \
        nextcloud-client \
        openssl-devel \
        p7zip \
        piper \
        qdirstat \
        qemu \
        rhythmbox \
        ruby \
        ruby-devel \
        shellcheck \
        shfmt \
        thunderbird \
        trash-cli \
        tree \
        ufw \
        unace \
        unrar \
        vlc \
        xdotool \
        xsel \
        yt-dlp \
        zenity \
        zoxide \
        zpaq \
        zstd

    # Texpander
    echo "Installing Texpander..."
    if [ ! -d "${HOME}/bin" ]; then mkdir -p "${HOME}/bin"; fi
    curl -o "${HOME}/bin/texpander" "https://raw.githubusercontent.com/leehblue/texpander/master/texpander.sh"
    chmod +x "${HOME}/bin/texpander"

    echo "Installing Atuin..."
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
}

configurePackages() {
    # Configure: texpander
    if [ ! -d "${HOME}/.texpander" ]; then
        mkdir -p "${HOME}/.texpander"
        echo -e "Created Texpander config directory at ${BLUE}${HOME}/.texpander${RESET}."
    fi
    echo -e "Remember to set up a keyboard shortcut pointing to ${BLUE}${HOME}/bin/texpander${RESET}."

    # Configure: input-remapper
    echo -n "Registering input-mapper daemon... "
    $SUDO_CMD systemctl enable --now input-remapper
    echo -e "${GREEN}Done!${RESET}"
}

checkEnv
installPackages
configurePackages
