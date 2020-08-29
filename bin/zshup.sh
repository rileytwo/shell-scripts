#!/usr/bin/env bash

B="$(echo -e "\e[1;94m")"
G="$(echo -e "\e[1;92m")"
E="$(echo -e "\e[0m")"

if [[ -z "$ZSH_CUSTOM" ]]; then
  ZSH_CUSTOM="${ZSH}/custom"
  ZSH_CUSTOM_PLUGINS="${ZSH_CUSTOM}/plugins"
fi

function usage() {
  echo
  echo "Usage: ${0##*/}"
  echo "  ${0##*/} update"
  echo "  ${0##*/} list"
  echo
  exit 1
}

function zshup_update() {
  for dir in "${ZSH_CUSTOM_PLUGINS}"/*; do
    if [[ -d "$dir" ]]; then
      case "$dir" in
      "${ZSH_CUSTOM_PLUGINS}/example")
        continue
        ;;
      *)
        cd "$dir" || { echo "cd failed.. is $dir a directory?"; }
        echo "${B}Updating ${G}${dir##*/}...${E}"
        git pull --rebase
        ;;
      esac

    elif [[ -f "$dir" ]]; then
      echo "$dir is a file!"

    fi
  done

  exit 0
}

function zshup_list() {
  for dir in "${ZSH_CUSTOM_PLUGINS}"/*; do
    if [[ -d "$dir" ]]; then
      case "$dir" in
      "${ZSH_CUSTOM_PLUGINS}/example")
        continue
        ;;
      *)
        echo "${dir##*/}"
        ;;
      esac

    elif [[ -f "$dir" ]]; then
      echo "$dir is a file!"

    fi
  done

  exit 0
}


function main() {
  if [[ "$#" == 0 ]]; then
    echo "Expected a command (${0##*/} update)"
    usage
    exit 1
  fi

  while [[ "$#" -gt 0 ]]; do
    opt="$1"
    case "$opt" in
      -h|--help)
        usage
        ;;
      --update|update)
        zshup_update
        ;;
      --list|list)
        zshup_list
        ;;
      *)
        usage
        ;;
    esac
  done
}

main "$@"