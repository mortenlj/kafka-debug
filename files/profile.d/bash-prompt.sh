#!/usr/bin/env bash
# @gf3’s Sexy Bash Prompt, inspired by “Extravagant Zsh Prompt”
# Shamelessly copied from https://github.com/gf3/dotfiles

default_username='unknown'
PROMPTCHAR="\$"

# determine arch
MACHINE="$(uname -m)"

case "${MACHINE}" in
    aarch64)
        ARCH="/arm64"
        ;;
    x86_64)
        ARCH=""
        ;;
    *)
        ARCH="/${MACHINE}"
        ;;
esac

HYPRIOT_OS=""

if [[ -r /etc/os-release ]]; then
    source /etc/os-release
fi

if [[ -n "${HYPRIOT_OS}" ]]; then
    NAME="HypriotOS"
elif [[ -r /etc/synoinfo.conf ]]; then
    NAME="SynologyNAS"
elif [[ "$(uname)" == "Darwin" ]]; then
    NAME="MacOSX"
fi
OSNAME="${NAME}${ARCH}: "

if [[ "${COLORTERM}" == gnome-* && "${TERM}" == xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
  tput sgr0
  if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
    BLUE=$(tput setaf 4)
    MAGENTA=$(tput setaf 9)
    ORANGE=$(tput setaf 172)
    GREEN=$(tput setaf 70)
  else
    BLUE=$(tput setaf 4)
    MAGENTA=$(tput setaf 5)
    ORANGE=$(tput setaf 3)
    GREEN=$(tput setaf 2)

  fi
  BOLD=$(tput bold)
  RESET=$(tput sgr0)
else
  BLUE=$'\033[1;34m'
  MAGENTA=$'\033[1;31m'
  ORANGE=$'\033[1;33m'
  GREEN=$'\033[1;32m'
  BOLD=''
  RESET=$'\033[m'
fi


# Only show username/host if not default
function usernamehost() {
  if [[ "${USER}" != "${default_username}" ]]; then
    echo "${BLUE}${OSNAME}${MAGENTA}${USER}${RESET}${BOLD}@${ORANGE}${HOSTNAME}${RESET}${BOLD} in ";
  else
    echo "${BLUE}${OSNAME}";
  fi
}

# iTerm Tab and Title Customization and prompt customization
# http://sage.ucsc.edu/xtal/iterm_tab_customization.html

# Put the string " [bash]   hostname::/full/directory/path"
# in the title bar using the command sequence
# \[\e]2;[bash]   \h::\]$PWD\[\a\]

# Put the penultimate and current directory
# in the iterm tab
# \[\e]1;\]$(basename $(dirname $PWD))/\W\[\a\]

PS1="\[\e]2;$PWD\[\a\]\[\e]1;\]$(basename "$(dirname "$PWD")")/\W\[\a\]${BOLD}\$(usernamehost)\[$GREEN\]\w\[$RESET\]\[$BOLD\]\n${PROMPTCHAR} \[$RESET\]"
