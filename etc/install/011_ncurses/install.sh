#!/bin/bash
set -eu

# ライブラリスクリプトを読み込む
. ${DOTVIM?"export DOTVIM=~/dotvim"}/bin/lib/dry_run.sh
. ${DOTVIM?"export DOTVIM=~/dotvim"}/bin/lib/is_installed_yum.sh

function usage() {
  cat <<EOF 1>&2
Description:
  $(basename ${0}) は ncurses-devel をインストールするスクリプトである。

Usage:
  $(basename ${0}) [-h] [-x]

Options:
  -h print this
  -x dry-run モードで実行する
EOF
  exit 0
}

while getopts hx OPT
do
  case "$OPT" in
    h) usage ;;
    x) enable_dryrun ;;
    \?) usage ;;
  esac
done


# 環境に `yum` を使って ncurses-devel がインストールされていなければインストールする
is_installed_yum ncurses-devel
if [[ $? -eq 0 ]]; then
  ${dryrun} sudo yum -y install ncurses-devel 
fi

exit 0
