#!/bin/bash
set -eu

# ライブラリスクリプトを読み込む
. ${DOTVIM?"export DOTVIM=~/dotvim"}/bin/lib/dry_run.sh

function usage() {
  cat <<EOF 1>&2
Description:
  $(basename ${0}) は FZF の設定を ~/.bashrc に追記するスクリプトである。

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

# ~/.bashrc に設定が存在する場合は処理を終了する
grep -q "source ~/.fzf.bash" ~/.bashrc && exit 0

# ~/.bashrc に追記する内容
setting=$(cat << EOS

# FZF
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
EOS
)
# ~/.bashrc に FZF の設定を追記する
if [ ! -z ${dryrun} ]; then
  echo "${setting} >> ~/.bashrc"
else
  echo "${setting}" >> ~/.bashrc
fi

exit 0
