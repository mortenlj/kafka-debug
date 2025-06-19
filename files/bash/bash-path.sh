#!/usr/bin/env bash

function append_path() {
  if [[ -d ${1} ]]; then
    PATH="${PATH}:${1}"
  fi

  export PATH
}

for d in /mise_pipx/installs/*/latest/bin; do
  append_path $d
done
