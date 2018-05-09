#!/bin/bash
set -eu

function usage() {
  cat <<EOF 1>&2
Description:
  $(basename ${0}) は ~/.vimrc の設定を行うスクリプトである。

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

if [[ -d ~/.cache/dein/ ]]; then
  rm -fr ~/.cache/dein/
fi
if [[ -d ~/.cache/neocomplete/ ]]; then
  rm -fr ~/.cache/neocomplete/
fi
if [[ -d ~/.cache/neosnippet/ ]]; then
  rm -fr ~/.cache/neosnippet/
fi

dir_rc=~/.vim/rc/
if [[ ! -d ${dir_rc} ]]; then
  mkdir ${dir_rc}
fi
cp ${DOTVIM?"export DOTVIM=~/dotvim"}/etc/deploy/01_vim/dein.toml ${dir_rc}
cp ${DOTVIM}/etc/deploy/01_vim/dein_lazy.toml ${dir_rc}

vimrc=~/.vimrc
if [[ -f ${vimrc} ]]; then
  rm -f ${vimrc}
fi
cp ${DOTVIM}/etc/deploy/01_vim/_vimrc ${vimrc}

exit 0
