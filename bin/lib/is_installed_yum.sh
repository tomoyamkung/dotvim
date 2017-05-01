#!/bin/bash -eu
set -eu

function usage() {
  cat <<EOF 1>&2
Description:
  コマンドがインストールされているかを確認する。
  コマンドの存在確認は yum コマンドを使って行う。

Usage:
  $(basename ${0}) command_name

EOF
  exit 0
}

function is_installed_yum() {
  x=$(sudo yum list installed | grep $1 | wc -l)
  return $x
}
