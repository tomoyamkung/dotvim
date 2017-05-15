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

# このスクリプト内で各 install.sh の実行制御は行わない
# 各スクリプトで実行制御する
find ${DOTVIM}/etc/install/ -type f -name "install.sh" | sort | xargs -i ${dryrun} sh {}

exit 0
