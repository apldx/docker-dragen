#!/bin/bash

argn=0

set -o nounset
set -o errexit
set -o pipefail

E_BADARGS=65

ee () { echo -e "$@" 1>&2; }

script=$(basename "$0")

usage=$(cat <<HERE
USAGE: $script
HERE
)

while getopts ":rm" opt; do
  case $opt in
    r)
      # Flag-style option
      echo "4.18.0"
      ;;
    m)
      # Flag-style option
      echo "x86_64"
  esac
done

shift $((OPTIND-1))

if [ $# -ne $argn ]; then
  ee "$usage"
  exit $E_BADARGS
fi
