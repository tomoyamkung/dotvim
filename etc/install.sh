#!/bin/bash
set -eu

# ライブラリスクリプトを読み込む
. ${DOTVIM?"export DOTVIM=~/dotvim"}/bin/lib/dry_run.sh
. ${DOTVIM?"export DOTVIM=~/dotvim"}/bin/lib/is_installed.sh

function usage() {
  cat <<EOF 1>&2
Description:
  $(basename ${0}) は etc/install/**/install.sh を一括して実行するスクリプトである。

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


# 環境に Vim がインストールされている場合は Vim 関連の install.sh は実行しない
is_installed vim
if [[ $? -ne 0 ]]; then
  ${dryrun} find etc/install/ -type d -name "01*" | sort | xargs -i sh {}/install.sh
fi

exit 0
