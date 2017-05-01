#!/bin/bash -eu
set -eu

# テスト用のライブラリスクリプトを読み込む
. ${DOTVIM?"export DOTVIM=~/dotvim"}/test/bin/lib/test_lib.sh

# テスト対象のスクリプトを読み込む
script_path=`get_product_script_path $(basename ${0})`
. "${script_path}"

# 関数名を取得して実行する
script_name=`get_script_name "${script_path}"`

x=`${script_name} lua`
if [[ $x -ne 0 ]]; then
  echo "lua は yum を使ってインストールされています"
fi


x=`${script_name} lua-devel`
if [[ $x -eq 0 ]]; then
  echo "lua-devel は yum を使ってインストールされていません"
fi

exit 0
