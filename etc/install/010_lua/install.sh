#!/bin/bash
set -eu

# ライブラリスクリプトを読み込む
. ${DOTVIM?"export DOTVIM=~/dotvim"}/bin/lib/dry_run.sh
. ${DOTVIM?"export DOTVIM=~/dotvim"}/bin/lib/is_installed.sh
. ${DOTVIM?"export DOTVIM=~/dotvim"}/bin/lib/is_installed_yum.sh

function usage() {
  cat <<EOF 1>&2
Description:
  $(basename ${0}) は lua および lua-devel をインストールするスクリプトである。

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

# 環境に Vim がインストールされている場合は終了する
# lua を有効にした Vim をインストールするために lua をインストールするので、Vim がインストールされていなければ処理を終了する
is_installed vim && exit 1

# 環境に `yum` を使って lua がインストールされていなければインストールする
is_installed lua
if [[ $? -ne 0 ]]; then
  ${dryrun} sudo yum -y install lua 
fi

# 環境に `yum` を使って lua-devel がインストールされていなければインストールする
is_installed_yum lua-devel
if [[ $? -eq 0 ]]; then
  ${dryrun} sudo yum -y install lua-devel 
fi

exit 0
