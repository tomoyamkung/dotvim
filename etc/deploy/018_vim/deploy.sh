#!/bin/bash
set -eu

# ライブラリスクリプトを読み込む
. ${DOTVIM?"export DOTVIM=~/dotvim"}/bin/lib/dry_run.sh

function usage() {
  cat <<EOF 1>&2
Description:
  $(basename ${0}) は ~/.vimrc の設定を行うスクリプトである。
  - ~/.vimrc が存在しない場合は ~/.vimrc を作成する
  - ~/.vimrc が存在する場合は etc/deploy/018_vim/vimrc を参照するように設定を追記する

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

# ~/.vimrc が存在する場合
if [[ -f ~/.vimrc ]]; then
  # ~/.vimrc は存在して、かつ、etc/deploy/018_vim/vimrc を参照する設定が存在する場合は終了する
  grep -q "runtime! 018_vim/vimrc" ~/.vimrc && exit 0

  # 設定が存在しない場合は etc/deploy/018_vim/vimrc に既存の設定を追記する形で ~/.vimrc を作り直す
  ${dryrun} cp ${DOTVIM}/etc/deploy/018_vim/initial_config /tmp/.vimrc
  ${dryrun} echo "" >> /tmp/.vimrc  # 見やすくするために１行挿入しておく
  ${dryrun} cat ~/.vimrc >> /tmp/.vimrc
  ${dryrun} mv /tmp/.vimrc ~/.vimrc
else  # ~/.vimrc が存在しない場合
  ${dryrun} cp ${DOTVIM}/etc/deploy/018_vim/initial_config ~/.vimrc
fi

exit 0
