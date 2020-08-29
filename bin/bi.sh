#!/usr/bin/env zsh

YLW="$(echo -e "\e[1;93m")"
GRN="$(echo -e "\e[1;92m")"
BLU="$(echo -e "\e[1;94m")"
RED="$(echo -e "\e[1;91m")"
END="$(echo -e "\e[0m")"

NAME="$(basename $0)"

function print_usage() {
  echo ""
  echo "${NAME} takes an application (or application name) as input and"
  echo "prints the associated CFBundleIdentifier from the application's"
  echo "Info.plist."
  echo ""
  echo "${YLW}USAGE:${END} ${BLU}${NAME}${END}"
  echo "  ${BLU}bi.sh${END} [APPLICATION NAME]"
  echo ""
  echo "${YLW}ARGS${END}:"
  echo "  <APPLICATION NAME>"
  echo "    The full name of an application located in /Applications."
  echo ""
  echo "    For example, to print the CFBundleIdentifier of Safari:"
  echo ""
  echo "      bi.sh Safari.app"
  echo ""
  echo "    Applications with a space in their name need to be escaped."
  echo ""
  echo "      bi.sh Safari\ Technology\ Preview.app"
  echo ""
  echo "  ${GRN}-h${END}"
  echo "    Display this message and exit."
  echo ""
  exit 1
}

function raise_error() {
  local error_message="$*"
  echo "${error_message}" 1>&2
}

function check_plistbuddy() {
  local no_plistbuddy_found="PlistBuddy was not found"

  if [[ -f "/usr/libexec/PlistBuddy" ]]; then
    PBDY="/usr/libexec/PlistBuddy"
  else
    echo "${no_plistbuddy_found}"; exit 1;
  fi
}

function resolve_app_name() {
  if ! [[ "$@" =~ .app ]]; then
    echo "$@.app" 2>&1 >/dev/stdout
  else
    echo "$@" 2>&1 >/dev/stdout
  fi
}

function resolve_path() {
  if [[ -d "$@" ]]; then
    echo "$@" 2>&1 >/dev/stdout
  else
    echo "/Applications/$@"
  fi
}

function print_bundle_identifier() {
  ${PBDY} -c 'Print CFBundleIdentifier' "$@"/Contents/Info.plist
}


function main() {
  check_plistbuddy

  app_name="$(resolve_app_name "$@")"
  app="$(resolve_path "$app_name")"

  if [ "$#" -gt 0 ]; then
    print_bundle_identifier "$app"
  else
    print_usage
  fi
}

main "$@"