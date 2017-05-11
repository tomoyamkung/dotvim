#!/bin/bash
set -eu

# ライブラリスクリプトを読み込む
. ${DOTVIM?"export DOTVIM=~/dotvim"}/bin/lib/dry_run.sh
. ${DOTVIM?"export DOTVIM=~/dotvim"}/bin/lib/is_installed.sh
. ${DOTVIM?"export DOTVIM=~/dotvim"}/bin/lib/create_dir.sh

function usage() {
  cat <<EOF 1>&2
Description:
  $(basename ${0}) は FZF をインストールするスクリプトである。
    - [junegunn/fzf: A command-line fuzzy finder written in Go](https://github.com/junegunn/fzf)
  FZF のインストールディレクトリは以下の設定ファイルに定義してある変数 FZF_INSTALL_DIRECTORY で指定する。
  デフォルトのインストールディレクトリは ~/.fzf となっている
    - ${DOTPATH}/etc/config/install_config.sh
  FZF が既にインストールされている場合は処理を中断するようになっているため、再インストールする場合は FZF をアンインストールすること。
  FZF は GitHub から clone するため git コマンドが使えることが前提となっている。

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


# 環境に FZF がインストールされている場合は処理を終了する
is_installed fzf && exit 1

# 設定ファイルを読み込む
. ${DOTVIM?"export DOTVIM=~/dotvim"}/etc/config/install_config.sh

# FZF のインストールに必要なディレクトリを（存在しなければ）作成する
${dryrun} create_dir ${FZF_INSTALL_DIRECTORY}

# GitHub からプロジェクトを clone してインストールスクリプトを実行する
${dryrun} git clone --depth 1 https://github.com/junegunn/fzf.git ${FZF_INSTALL_DIRECTORY}
${dryrun} sh ${FZF_INSTALL_DIRECTORY}/install --all
exit 0
