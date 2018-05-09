#!/bin/bash
set -eu

function usage() {
  cat <<EOF 1>&2
Description:
  $(basename ${0}) は Vim と FZF の連携設定を行うスクリプトである。
  Vim 起動時に ":FZF" と実行することでカレントディレクトリ以下のファイルが FZF によって絞りこめるようになる

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

# ~/.vimrc に FZF の設定を追記する
vimrc=~/.vimrc
cat ${DOTVIM?"export DOTVIM=~/dotvim"}/etc/deploy/02_fzf/_vimrc >> ${vimrc}

exit 0
