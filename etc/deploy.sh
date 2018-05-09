#!/bin/bash
set -eu

function usage() {
  cat <<EOF 1>&2
Description:
  $(basename ${0}) は etc/deploy/**/deploy.sh を一括して実行するスクリプトである。

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

find ${DOTVIM?"export DOTVIM=~/dotvim"}/etc/deploy -name "deploy.sh" | sort | xargs -i sh {}

exit 0
