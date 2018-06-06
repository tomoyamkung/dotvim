#!/bin/bash
set -eu

function usage() {
  cat <<EOF 1>&2
Description:
  $(basename ${0}) は以下を一括して実行するスクリプトである。
  1. dotsubmodule/lib/fzf/install.sh
  2. etc/install/**/install.sh

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

export DOTVIM=~/dotvim
find "${DOTVIM}"/dotsubmodule/ -type f -name "install.sh" | xargs -i sh {}
find ${DOTVIM?"export DOTVIM=~/dotvim"}/etc/install/ -type f -name "install.sh" | sort | xargs -i sh {}

exit 0
