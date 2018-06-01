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
  sudo git clone https://github.com/vim/vim.git
fi
cd vim
sudo ./configure --enable-fail-if-missing --prefix=/usr/local/ --with-features=huge --disable-selinux --enable-cscope --enable-multibyte --enable-luainterp --enable-pythoninterp=dynamic
sudo make
sudo make install

# Vim のカラースキームをインストールする
cd ~/
vim_colors_dir=~/.vim/colors
if [[ ! -d "${vim_colors_dir}" ]]; then
  mkdir -p "${vim_colors_dir}"
fi
clone_colorscheme_dir=~/.vim_colorscheme
if [[ ! -d "${clone_colorscheme_dir}" ]]; then
  mkdir "${clone_colorscheme_dir}"
fi
# Vitamins
vitamins=vim-vitamins
if [[ ! -d "${clone_colorscheme_dir}"/"${vitamins}" ]]; then
  git clone https://github.com/fmoralesc/vim-vitamins.git "${clone_colorscheme_dir}"/"${vitamins}"
fi
# iceberg
iceberg=iceberg
if [[ ! -d "${clone_colorscheme_dir}"/"${iceberg}" ]]; then
  git clone https://github.com/cocopon/iceberg.vim.git "${clone_colorscheme_dir}"/"${iceberg}"
fi
# papercolor-theme
papercolor=papercolor-theme
if [[ ! -d "${clone_colorscheme_dir}"/"${papercolor}" ]]; then
  git clone https://github.com/NLKNguyen/papercolor-theme.git "${clone_colorscheme_dir}"/"${papercolor}"
fi
find "${clone_colorscheme_dir}"/*/colors/ -type f -name "*.vim" | xargs -i cp {} "${vim_colors_dir}"/

exit 0
