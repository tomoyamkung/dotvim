#!/bin/bash -eu
set -eu

# テスト用のライブラリスクリプトを読み込む
. ${DOTVIM?"export DOTVIM=~/dotvim"}/test/bin/lib/test_lib.sh

# テスト対象のスクリプトを読み込む
script_path=`get_product_script_path $(basename ${0})`
. "${script_path}"

# 関数名を取得して実行する
script_name=`get_script_name "${script_path}"`

`${script_name} ls` || echo "ls はインストールされています"
`${script_name} dummy` && echo "dummy はインストールされていません"

exit 0
