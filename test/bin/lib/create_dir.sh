#!/bin/bash -eu

# テスト用のライブラリスクリプトを読み込む
# TODO パスにプロジェクト名を直接指定するのを回避したい
. ~/dotvim/test/bin/lib/test_lib.sh

# テスト対象のスクリプトを読み込む
script_path=`get_product_script_path $(basename ${0})`
script_name=`get_script_name "${script_path}"`

. "${script_path}"

`${script_name} /usr/local` && echo "ディレクトリ /usr/local は存在します"

exit 0
