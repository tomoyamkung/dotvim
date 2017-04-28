#!/bin/bash -eu

# テストスクリプトと対になるプロダクトスクリプトの絶対パスを取得する
# usage: script_path=`get_product_script_path $(basename ${0})`
function get_product_script_path() {
  find ${DOTVIM} -type f -name ${1} | grep -v "test"
}

# スクリプトファイル名から拡張子 .sh を取り除く
# usage: script_name=`get_script_name "${script_path}"`
function get_script_name() {
  basename "${1}" .sh
}
