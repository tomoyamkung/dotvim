# dotvim

dotvim とは以下を実行するプロジェクトである。

- Vim のインストール、および、設定
- [fzf](https://github.com/junegunn/fzf) のインストール、および、Vim との連携設定

必要最小限の構成とするためプラグインのインストールは行わない。
また、制約のある環境でもインストールさせたいので、デフォルトでは ~/src ディレクトリに Vim をインストールするようになっている（インストールディレクトリは変更可能）。


# セットアップ手順

セットアップ手順は以下の通り。

```
$ cd ~/
$ git clone https://github.com/tomoyamkung/dotvim.git
$ cd dotvim
$ export DOTVIM=~/dotvim
$ ./etc/install.sh  # 本プロジェクトが提供する機能に必要なソフトウェアのインストールを行う
$ ./etc/deploy.sh  # 本プロジェクトが提供する機能を設定にする
$ . ~/.bashrc  # ~/.bashrc の設定を有効にする
```


# 提供機能

本プロジェクトが提供する機能は非常にシンプルであり、以下だけである。

- Vim のインストール、および、設定
- [fzf](https://github.com/junegunn/fzf) のインストール、および、Vim との連携設定

セットアップ手順実行後は以下が有効になる。

- ~/.vimrc が設定されること
- fzf が有効になっていること
- Vim と fzf が連携されること


## Vim のインストールについて

Vim のインストール仕様は以下の通り。

- Vim は Github からプロジェクトを clone してソースコードからインストールする
- インストールディレクトリは~/src/vim とする（変更可能）
- `configure` オプションで lua, python が有効となるように指定する

インストールした Vim について `vim --version` の結果は以下の通り。

```
$ vim --version
VIM - Vi IMproved 8.0 (2016 Sep 12, compiled xxx xx xxxx xx:xx:xx)
Included patches: 1-597
Compiled by vagrant@localhost.localdomain
Huge version without GUI.  Features included (+) or not (-):
+acl             +file_in_path    +mouse_sgr       +tag_old_static
+arabic          +find_in_path    -mouse_sysmouse  -tag_any_white
+autocmd         +float           +mouse_urxvt     -tcl
-balloon_eval    +folding         +mouse_xterm     +termguicolors
-browse          -footer          +multi_byte      +terminfo
++builtin_terms  +fork()          +multi_lang      +termresponse
+byte_offset     +gettext         -mzscheme        +textobjects
+channel         -hangul_input    +netbeans_intg   +timers
+cindent         +iconv           +num64           +title
-clientserver    +insert_expand   +packages        -toolbar
-clipboard       +job             +path_extra      +user_commands
+cmdline_compl   +jumplist        -perl            +vertsplit
+cmdline_hist    +keymap          +persistent_undo +virtualedit
+cmdline_info    +lambda          +postscript      +visual
+comments        +langmap         +printer         +visualextra
+conceal         +libcall         +profile         +viminfo
+cryptv          +linebreak       +python/dyn      +vreplace
+cscope          +lispindent      -python3         +wildignore
+cursorbind      +listcmds        +quickfix        +wildmenu
+cursorshape     +localmap        +reltime         +windows
+dialog_con      +lua             +rightleft       +writebackup
+diff            +menu            -ruby            -X11
+digraphs        +mksession       +scrollbind      -xfontset
-dnd             +modify_fname    +signs           -xim
-ebcdic          +mouse           +smartindent     -xpm
+emacs_tags      -mouseshape      +startuptime     -xsmp
+eval            +mouse_dec       +statusline      -xterm_clipboard
+ex_extra        -mouse_gpm       -sun_workshop    -xterm_save
+extra_search    -mouse_jsbterm   +syntax         
+farsi           +mouse_netterm   +tag_binary     
   system vimrc file: "$VIM/vimrc"
     user vimrc file: "$HOME/.vimrc"
 2nd user vimrc file: "~/.vim/vimrc"
      user exrc file: "$HOME/.exrc"
       defaults file: "$VIMRUNTIME/defaults.vim"
  fall-back for $VIM: "/home/vagrant/src/share/vim"
Compilation: gcc -c -I. -Iproto -DHAVE_CONFIG_H     -g -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
Linking: gcc   -L/usr/local/lib -Wl,--as-needed -o vim        -lm -ltinfo -lnsl   -ldl  -L/usr/lib -llua
```


## Vim の設定について

Vim については以下の設定を提供する。

- ~/.vimrc が存在しない場合は作成する
- ~以下設定ファイルへの参照を ~/.vimrc に追加する
    - etc/deploy/018_vim/vimrc

上記の設定ファイルについてカスタマイズらしい内容は以下の通り。

- Buffer の設定（プレフィックスを space + b に変更）
- vimgrep + quickfix-window（:vim[grep] での検索結果を自動的に quickfix-window で表示するためのもの）

~./vimrc に設定を追加する場合は etc/deploy/018_vim/vimrc ではなく ~/.vimrc に行うこと。


## fzf

fzf 関連については以下の設定を提供する。

- fzf を有効にするための設定を ~/.bashrc に追加する
- Vim から fzf を使ってフィルタするための設定を ~/.vimrc に追加する

~/.bashrc に追加した設定を反映にするには `. /.bashrc` をするが、これは各自で行うこと。 


# インストールディレクトリの設定

Vim および fzf のインストールディレクトリは以下の設定ファイルで変更できるようになっている。

- etc/config/install_config.sh

デフォルトの内容は以下の通り。

```
$ cat etc/config/install_config.sh

# Vim
VIM_INSTALL_PREFIX_DIRECTORY=~/src
VIM_BIN_DIRECTORY=~/bin

# FZF
FZF_INSTALL_DIRECTORY=~/src/fzf
```

上記の場合 Vim は ~/src/vim ディレクトリにソースコードが clone されるようになる。 これは configure のパラメータも兼ねているためこのような指定としている。  
`VIM_BIN_DIRECTORY` は `make` で作成される vim ファイル（他にもファイルは作成される）の保管ディレクトリを指定するためのものである。

fzf についても `/src/fzf ディレクトリにソースコードが clone されるようになる。
インストール後に作成される .fzf.bash は ~/ に保管される。これは fzf のデフォルトである。


# 仕様・制限事項

本プロジェクトの全体的な仕様、および、制限事項は以下の通り。

- 本プロジェクトは CentOS で開発され CentOS 上での使用を想定しているため、基本的に CentOS 以外での使用は考慮していない
- Git は既に環境にインストールされている状態とする
- シェルは bash を対象とする

