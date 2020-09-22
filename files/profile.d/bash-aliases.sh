#!/bin/bash
# You may uncomment the following lines if you want `ls' to be colorized:

function set_ls_options() {
  local bash_path
  bash_path="$(command -v bash)"
  local dc_shell
  dc_shell="${SHELL:-${bash_path}}"

  if ls --color=auto &> /dev/null; then
    export LS_OPTIONS='--color=auto'
    eval "$(SHELL=${dc_shell} dircolors)"
  fi
}

set_ls_options

alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
