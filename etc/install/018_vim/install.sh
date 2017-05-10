#!/bin/bash
set -eu

# ライブラリスクリプトを読み込む
. ${DOTVIM?"export DOTVIM=~/dotvim"}/bin/lib/dry_run.sh
. ${DOTVIM?"export DOTVIM=~/dotvim"}/bin/lib/is_installed.sh
. ${DOTVIM?"export DOTVIM=~/dotvim"}/bin/lib/create_dir.sh

function usage() {
  cat <<EOF 1>&2
Description:
  $(basename ${0}) は Vim をインストールするスクリプトである。
  Vim は Github からソースコードを clone してインストールする。

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
is_installed vim && exit 1

# 設定ファイルを読み込む
. ${DOTVIM?"export DOTVIM=~/dotvim"}/etc/config/install_config.sh

# Vim のインストールに必要なディレクトリを（存在しなければ）作成する
${dryrun} create_dir ${VIM_INSTALL_PREFIX_DIRECTORY}
${dryrun} create_dir ${VIM_BIN_DIRECTORY}

# インストールディレクトリに移動して Vim をインストールする
${dryrun} cd ${VIM_INSTALL_PREFIX_DIRECTORY}
${dryrun} git clone https://github.com/vim/vim.git
${dryrun} cd vim
${dryrun} ./configure --enable-fail-if-missing --prefix=${VIM_INSTALL_PREFIX_DIRECTORY} --with-features=huge --disable-selinux --enable-cscope --enable-multibyte --enable-luainterp --enable-pythoninterp=dynamic --bindir=${VIM_BIN_DIRECTORY}
${dryrun} make
${dryrun} make install

exit 0
