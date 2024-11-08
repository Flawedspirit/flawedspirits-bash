#!/usr/bin/env bash
iatest=$(expr index "$-" i)

################################################################
#&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&&&&&&&&&&&&&&&(***&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&&&&&&&&&&&&&********(&&&&&&&&&&&&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&&&&&&&&&&(*************&&&&&&&&&&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&&&&&&&%********//********(&&&&&&&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&&&&&(********(&&&&#********(&&&&&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&&%********/%&&&&&&&&%/**/#&&(,(&&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&%*******(&&&&&&&&&&&&&&&&%*,,,,(&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&%********&&&&&&&&&&&&&&(,,,,,,,(&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&%**********(&&&&&&&&%,,,,,,,,*,(&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&%*************&&&&(,,*,,,,,,,*,(&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&%*****/#****/&&%,,,,,,,,((,,,*,(&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&%*****/&&&%@&(,,,,,,,*%&&(,,,,,(&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&%*****/&&&&&#,,,,,,,,(&&&(,,,,,(&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&%*****/&&&&&&&&/,,,,,,,,%&&*,,,(&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&%*****/&&&&&&&&&&#,*,,,,,,(&&(,(&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&%*****/&&&&&&&&&&&&&/,,,,,,,*%&&&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&&######&&&&&&&&&&&&&&&#,,,,,*,,(&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&%,,,,*,,%&&&&&&&&&&&&&&&/,,,,,,(&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&&/,,,,,,,,(&&&&&&&&&&%*,,,,,,,*%&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&&&&#,,,,,,,,*%&&&&&/,,,,,,,*(&&&&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&&&&&&&/,,,,,,,,(%,,,,,,,,*%&&&&&&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&&&&&&&&&#,,,,,,,,,,,,,,(&&&&&&&&&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&&&&&&&&&&&&*,,,*,,,,*&&&&&&&&&&&&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&&&&&&&&&&&&&&#,*,,(&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
#################### FLAWEDSPIRIT'S .BASHRC ####################

if [ -f /usr/bin/fastfetch ]; then
  /usr/bin/fastfetch
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
  source /etc/bashrc
fi

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
  source /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi

# Enable atuin history completions
if [ -f $HOME/.config/atuin-completion ]; then
  source $HOME/.config/atuin-completion
fi

#######################################
# TERMINAL OPTIONS
#######################################

# Disable the bell
if [[ $iatest -gt 0 ]]; then bind "set bell-style visible"; fi

# no duplicate entries or entries beginning with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

export HISTSIZE=1000
export HISTFILESIZE=20000
export HISTTIMEFORMAT="%F %T :: "

# Append to history instead of overwriting so history is still there when launching new Bash
shopt -s histappend
PROMPT_COMMAND=('history -a')

# Check window size after each command and resize lines and columns as necessary
shopt -s checkwinsize

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest -gt 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest -gt 0 ]]; then bind "set show-all-if-ambiguous on"; fi

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#######################################
# ARCHIVE EXTRACTION                  #
#######################################

# Usage: ex <file> [file2] [file3] ...
ex () {
  if [ $# -eq 0 ]; then
    #Display usage if no parameters given
    echo "Usage: ex <path/to/file1.ext> [path/to/file2.ext] ... [path/to/fileN.ext]"
    echo
    echo "Supported file formats:"
    echo "  7z|ace|apk|arc|arj|bz2|cab|cb7|cba|cbr|cbt|cbz|chm|cpio|cso|deb"
    echo "  epub|exe|gz|iso|lzh|lzma|msi|pkg|rar|rpm|tar|tar.bz2|tar.gz|tar.xz"
    echo "  tar.zst|tbz2|tgz|txz|udf|vhd|wim|xar|xz|z|zip|zlib|zpaq|zst"
  fi

  for n in "$@"; do
    if [ ! -f "$n" ]; then
      echo "File not found: $n"
      return 1
    fi

    case "${n%,}" in
      *.cbt|*.tar|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz)
                          tar zxvf ./"$n"    ;;
      *.lzma)             unlzma ./"$n"      ;;
      *.bz2)              bunzip2 ./"$n"     ;;
      *.cbr|*.rar)        unrar x -ad ./"$n" ;;
      *.gz)               gunzip ./"$n"      ;;
      *.cbz|*.epub|*.zip) unzip ./"$n"       ;;
      *.z)                uncompress ./"$n"  ;;
      *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.vhd|*.wim|*.xar)
                          7z x ./"$n"        ;;
      *.xz)               unxz ./"$n"        ;;
      *.exe)              cabextract ./"$n"  ;;
      *.cpio)             cpio -id < ./"$n"  ;;
      *.ace|*.cba)        unace x ./"$n"     ;;
      *.zpaq)             zpaq x ./"$n"      ;;
      *.arc)              arc e ./"$n"       ;;
      *.cso)              ciso 0 ./"$n" ./"$n.iso" && ex "$n.iso" && rm -f "$n" ;;
      *.zlib)             zlib-flate -uncompress < ./"$n" > ./"$n.tmp" && mv ./"$n.tmp" ./"${n%.*zlib}" && rm -f "$n" ;;
      *.tar.zst)          tar -I zstd -xvf ./"$n" ;;
      *.zst)              zstd -d ./"$n"     ;;
      *)                  echo "Unknown archive format or damaged file: $n"
                          return 2 ;;
    esac
  done
}

#######################################
# FUNCTIONS                           #
#######################################

# Copy directory and go: cp and enter it immediately
cpag() {
  if [ $# -eq 0 ]; then
    #Display usage if no parameters given
    echo "cpag: Copy directory and go"
    echo "Usage: cpag <old_dir> <new_dir>"
    return
  fi

  if [ -d "$2" ]; then
    cp "$1" "$2" && cd "$2" || return
  else
    cp "$1" "$2"
  fi
}

# Find string in file
fstr () {
  grep -Rnw "." -e "$1"
}

# Github
gcom() {
  if [ $# -eq 0 ]; then
    echo "Please provide a commit message."
    return
  fi
  git add .
  git commit -m "$1"
}

gupl() {
  if [ $# -eq 0 ]; then
    echo "Please provide a commit message."
    return
  fi
  git add .
  git commit -m "$1"
  git push
}

# Get md5/sha1/sha512 hash of file (use responsibly!)
hash() {
  local md5
  local sha1
  local sha512

  if [ $# -eq 0 ]; then
    #Display usage if no parameters given
    echo "hash: Get md5/sha1/sha512 of file"
    echo "Usage: hash <file>"
    return
  fi

  if [ ! -f "$1" ]; then
    echo "Argument must be a file."
    return
  fi

  md5=$(md5sum "$1" | cut -d ' ' -f 1)
  sha1=$(sha1sum "$1" | cut -d ' ' -f 1)
  sha512=$(sha512sum "$1" | cut -d ' ' -f 1)

  echo "Returning hash of file: $1"
  echo "MD5    $md5"
  echo "SHA1   $sha1"
  echo "SHA512 $sha512"
}

# Make directory and go: mkdir and enter it immediately
mdag() {
  if [ $# -eq 0 ]; then
    #Display usage if no parameters given
    echo "mdag: Make directory and go"
    echo "Usage: mdag <dir>"
    return
  fi
  mkdir -p "$1" && cd "$1" || return
}

mvag() {
  if [ $# -eq 0 ]; then
    #Display usage if no parameters given
    echo "mvag: Move directory and go"
    echo "Usage: mvag <old_dir> <new_dir>"
    return
  fi

  if [ -d "$2" ]; then
    mv "$1" "$2/" && cd "$2/" || return
  else
    mv "$1" "$2/"
  fi
}

# Navigation
up () {
  local show_help=false
  for arg in "$@"; do
    case $arg in
      -h|--help) show_help=true
        shift ;;
      *) break
    esac
  done

  if $show_help; then
    #Display usage if no parameters given
    echo "Usage: up [-h|--help] [num]"
    echo "  Where [num] is the number of directory levels you want to ascend (default 1)."
    echo "  -h or --help shows this help message."
    return 0
  fi

  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}

# Get clean distribution name
distribution() {
  local dtype="unknown" # Defaults to unknown

  # Use /etc/os-release for modern linux distros
  if [ -r /etc/os-release ]; then
    source /etc/os-release

    case $ID in
      fedora|rhel|centos) dtype="redhat"    ;;
      sles|opensuse*)     dtype="suse"      ;;
      ubuntu|debian)      dtype="debian"    ;;
      gentoo)             dtype="gentoo"    ;;
      arch|manjaro)       dtype="arch"      ;;
      slackware)          dtype="slackware" ;;
      *)
        # Check ID_LIKE only if distro is still unknown
        if [ -n "$ID_LIKE" ]; then
          case $ID_LIKE in
            *fedora*|*rhel*|*centos*) dtype="redhat"    ;;
            *sles*|*opensuse*)        dtype="suse"      ;;
            *ubuntu*|*debian*)        dtype="debian"    ;;
            *gentoo*)                 dtype="gentoo"    ;;
            *arch*|*manjaro*)         dtype="arch"      ;;
            *slackware*)              dtype="slackware" ;;
          esac
        fi

      # If ID or ID_LIKE are still unknown keep dtype as unknown
      ;;
    esac
  fi
  echo $dtype
}

# Show the current version of the operating system
ver() {
  local dtype
  dtype=$(distribution)

  case $dtype in
    "redhat")
      if [ -s /etc/redhat-release ]; then
          cat /etc/redhat-release
      else
          cat /etc/issue
      fi
      uname -a ;;
    "suse")
      cat /etc/SuSE-release ;;
    "debian")
      lsb_release -a ;;
    "gentoo")
      cat /etc/gentoo-release ;;
    "arch")
      cat /etc/os-release ;;
    "slackware")
      cat /etc/slackware-version ;;
    *)
      if [ -s /etc/issue ]; then
        cat /etc/issue
      else
        echo "Error: Unknown distribution."
        exit 1
      fi
      ;;
  esac
}

showmyip() {
  local INTERFACE="enp6s0"

  #Internal IP lookup
  if command -v ip &> /dev/null; then
    echo -n "󰛳 Internal IP: "
    ip addr show $INTERFACE | grep "inet " | awk '{print $2}' | cut -d/ -f1
  else
    echo -n "󰛳 Internal IP: "
    ifconfig $INTERFACE | grep "inet " | awk '{print $2}'
  fi

  echo -n " External IP: "
  curl -s ifconfig.me
}

#######################################
# ALIASES                             #
#######################################

# Adding flags to existing commands
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# Aliases for showing disk space and folder usage
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias dirtree='tree -CAFd'
alias tree='tree -CAhF --dirsfirst'
alias mountedinfo='df -hT'

# Cat to bat
DISTRIBUTION=$(distribution)
if [ "$DISTRIBUTION" = "redhat" ] || [ "$DISTRIBUTION" = "arch" ]; then
  alias cat='bat'
else
  alias cat='batcat'
fi

# chmod
alias makex='chmod a+x'
alias 000='chmod -R 000'
alias 600='chmod -R 600'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# Colourize grep output
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Confirm before overwriting something
alias cp='cp -vi'
alias mv='mv -vi'

# ls to exa
alias ll='eza -al --icons --color=always --group-directories-first --git' # my preferred listing
alias la='eza -a --icons --color=always --group-directories-first'        # all files and dirs
alias ls='eza -l --icons --color=always --group-directories-first --git'  # long format
alias lt='eza -aT --icons --color=always --group-directories-first'       # tree listing
alias l.='eza -a | egrep "^\."'

# Map rm to trash-cli so that file can be recovered later
alias rm='trash -v'

# More verbose copying
alias cpv='rsync -avh --info=progress2'

# Protontricks
alias protontricks='flatpak run com.github.Matoking.protontricks'
alias protontricks-launch='flatpak run --command=protontricks-launch com.github.Matoking.protontricks'

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# Search files
alias f="find . | grep "
alias ff="fzf -e"
alias fq="fzf -q"

# Show open ports
alias openports='netstat -nape --inet'

# yt-dlp
alias yta-aac="yt-dlp -o '$HOME/yt-dlp' --extract-audio --audio-format aac"
alias yta-best="yt-dlp --extract-audio --audio-format best "
alias yta-flac="yt-dlp --extract-audio --audio-format flac "
alias yta-m4a="yt-dlp --extract-audio --audio-format m4a "
alias yta-mp3="yt-dlp -o '$HOME/yt-dlp/%(title)s.%(ext)s' --extract-audio --audio-format mp3"
alias yta-opus="yt-dlp --extract-audio --audio-format opus "
alias yta-vorbis="yt-dlp --extract-audio --audio-format vorbis "
alias yta-wav="yt-dlp --extract-audio --audio-format wav "
alias ytv-best="yt-dlp -f bestvideo+bestaudio "

# Update OS and flatpaks
alias update='sudo dnf upgrade && flatpak update'

# Misc
alias b='cd $OLDPWD'
alias bashrc='nano ~/.bashrc'
alias c='clear'
alias count='ls * | wc -l'
alias etcher='$HOME/bin/etcher/balena-etcher'
alias ipaddr='showmyip'
alias mp3gain='find . -name "*.mp3" -exec mp3gain -a -k {} \;'
alias now='date "+%Y-%m-%d %A %T %Z"'
alias help='less ~/.bashrc_help'
alias home='cd $HOME'
alias man='tldr'
alias n='nano'
alias sn='sudo nano'

#######################################
# INSTALL BASHRC SUPPORT              #
#######################################

install_bashrc_support() {
  local dtype
  dtype=$(distribution)

  echo -e "\E[38;5;33mInstalling required packages...\E[0m"

  case $dtype in
    "redhat")
      sudo dnf install --refresh arc bash-completion bat cabextract exa fastfetch fzf net-tools p7zip qpdf trash-cli tree unace unrar yt-dlp zoxide zpaq zstd ;;
    "suse")
      echo "SUSE distributions are not yet supported by this installer." ;;
    "debian")
      sudo apt update && sudo apt install arc bash-completion bat cabextract ciso exa fzf net-tools qpdf trash-cli tree rar unace unrar yt-dlp zoxide zpaq zstd

      # Fetch the latest fastfetch release URL for linux-amd64 deb file
      FASTFETCH_URL=$(curl -s https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest | grep "browser_download_url.*linux-amd64.deb" | cut -d '"' -f 4)

      # Download the latest fastfetch deb file
      curl -sL "$FASTFETCH_URL" -o /tmp/fastfetch_latest_amd64.deb

      # Install the downloaded deb file using apt-get
      sudo apt install /tmp/fastfetch_latest_amd64.deb ;;
    "gentoo")
      echo "Gentoo distributions are not yet supported by this installer." ;;
    "arch")
      sudo paru bat;;
    "slackware")
      echo "Slackware distributions are not supported by this installer." ;;
    *)
      echo "Unknown distribution type. Exiting." ;;
  esac

  echo -e "\E[32mDone!\E[0m"

  echo -e "\E[38;5;33mInstalling required fonts...\E[0m"
  # Download required nerd font
  mkdir -p "$HOME/.fonts"

  FONT_URL=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep "browser_download_url.*CascadiaMono.zip" | cut -d '"' -f 4)
  curl -sL "$FONT_URL" -o /tmp/CascadiaMono.zip

  unzip -o /tmp/CascadiaMono.zip
  mv -f Caskaydia*.ttf "$HOME/.fonts"
  rm -f /tmp/CascadiaMono.zip

  echo -e "\E[32mDone! Remember to set your preferred font in your terminal settings.\E[0m"
}

#######################################
# WEBDEV HELPERS                      #
#######################################

alias cpdate='echo -n `date +"%Y-%m-%dT%H:%M:%S%:z"` | wl-copy; echo "Date and time copied to clipboard"'

#######################################
# SETTING THE FINAL PROMPT            #
#######################################

# Bind CTRL+F to zi and newline if shell is interactive
if [[ $- == *i* ]]; then
  bind '"\C-f":"zi\n"'
fi

export PATH="$HOME/.atuin/bin:$HOME/.bin:$HOME/bin:$HOME/gems/bin:$PATH"

eval "$(starship init bash)"
eval "$(zoxide init bash)"

[[ -f "$HOME/.bash-preexec.sh" ]] && source "$HOME/.bash-preexec.sh"
eval "$(atuin init bash)"
. "$HOME/.cargo/env"
