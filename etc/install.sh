#!/bin/bash
set -eu

function usage() {
  cat <<EOF 1>&2
Description:
  $(basename ${0}) は etc/install/**/install.sh を一括して実行するスクリプトである。

Usage:
  $(basename ${0}) [-h]

Options:
  -h print this
EOF
  exit 0
}

while getopts h OPT
do
  case "$OPT" in
    h) usage ;;
    \?) usage ;;
  esac
done

find ${DOTVIM?"export DOTVIM=~/dotvim"}/etc/install/ -type f -name "install.sh" | sort | xargs -i sh {}

exit 0
