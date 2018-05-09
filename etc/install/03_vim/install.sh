#!/bin/bash
set -eu

function usage() {
  cat <<EOF 1>&2
Description:
  $(basename ${0}) は Vim をインストールするスクリプトである。
  Vim は Github からソースコードを clone してインストールする。

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

# 環境に `yum` を使って lua をインストールする
if [[ ! $(sudo yum list installed | grep lua) ]]; then
  sudo yum -y install lua
fi

# 環境に `yum` を使って lua-devel がインストールされていなければインストールする
if [[ ! $(sudo yum list installed | grep lua-devel) ]]; then
  sudo yum -y install lua-devel
fi

# 環境に `yum` を使って ncurses-devel をインストールする
if [[ ! $(sudo yum list installed | grep ncurses-devel) ]]; then
  sudo yum -y install ncurses-devel
fi

# 環境に `yum` を使って python-devel をインストールする
if [[ ! $(sudo yum list installed | grep python-devel) ]]; then
  sudo yum -y install python-devel
fi

# インストールディレクトリに移動して Vim をインストールする
cd /usr/local/
if [[ ! -d vim ]]; then
  git clone https://github.com/vim/vim.git
fi
cd vim
sudo ./configure --enable-fail-if-missing --prefix=/usr/local/ --with-features=huge --disable-selinux --enable-cscope --enable-multibyte --enable-luainterp --enable-pythoninterp=dynamic
sudo make
sudo make install

exit 0
