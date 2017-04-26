#!/bin/bash -eu

# TODO パスにプロジェクト名を直接指定するのを回避したい
# TODO 簡単な使用例を書く
function get_product_script_path() {
  find ~/dotvim -type f -name ${1} | grep -v "test"
}

# TODO 簡単な使用例を書く
function get_script_name() {
  basename "${1}" .sh
}
