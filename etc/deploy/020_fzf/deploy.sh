#!/bin/bash
set -eu

# ライブラリスクリプトを読み込む
. ${DOTVIM?"export DOTVIM=~/dotvim"}/bin/lib/dry_run.sh
. ${DOTVIM?"export DOTVIM=~/dotvim"}/bin/lib/is_installed.sh

function usage() {
  cat <<EOF 1>&2
Description:
  $(basename ${0}) は Vim と FZF の連携設定を行うスクリプトである。
  Vim 起動時に ":FZF" と実行することでカレントディレクトリ以下のファイルが FZF によって絞りこめるようになる

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

# ~/.vimrc が存在しない場合は処理を終了する
[[ -f ~/.vimrc ]] || exit 0

# 設定ファイルを読み込む
. ${DOTVIM?"export DOTVIM=~/dotvim"}/etc/config/install_config.sh
# ~/.vimrc に FZF の設定がある場合は処理を終了する
grep -q "${FZF_INSTALL_DIRECTORY}" ~/.vimrc && exit 0


# FZF のインストールディレクトリを確認する
path=""
if [[ -d ${FZF_INSTALL_DIRECTORY} ]]; then
  # このプロジェクトのインストールスクリプトを使用して FZF をインストールした場合
  path="${FZF_INSTALL_DIRECTORY}"
elif [[ $(is_installed fzf; echo $?) == 0 ]]; then
  # 別の方法で FZF をインストールした場合
  path="$(type fzf | awk '{print $3}' | sed -e 's#/bin/fzf##')"
else
  # FZF がインストールされていない、もしくは PATH が通っていない場合は処理を終了する
  echo "fzf is not installed or is not found"
  exit 1
fi

# ~/.vimrc への設定内容
setting=$(cat << EOS

" FZF
set rtp+=${path}
EOS
)

# ~/.vimrc に FZF の設定を追記する
if [[ ! -z ${dryrun} ]]; then
  echo "${setting} >> ~/.vimrc"
else
  echo "${setting}" >> ~/.vimrc
fi

exit 0
