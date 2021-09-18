#!/usr/bin/env zsh

function check_quarantine() {
  if [[ "$@" =~ .app && $(xattr "$@") =~ quarantine ]]; then
    echo "$@ is quarantined";
  else
    :
  fi
}


