#---- プロンプト設定 ------#
# 左プロンプト
# PROMPT='[%n@%m %~]${WINDOW:+"[$WINDOW]"}%# '

## <エスケープシーケンス>
## prompt_bang が有効な場合、!=現在の履歴イベント番号, !!='!' (リテラル)
# ${WINDOW:+"[$WINDOW]"} = screen 実行時にスクリーン番号を表示 (prompt_subst が必要)
# %B = underline
# %/ or %d = ディレクトリ (0=全て, -1=前方からの数)
# %~ = ディレクトリ
# %h or %! = 現在の履歴イベント番号
# %L = 現在の $SHLVL の値
# %M = マシンのフルホスト名
#  %m = ホスト名の最初の `.' までの部分
# %S (%s) = 突出モードの開始 (終了)
# %U (%u) = 下線モードの開始 (終了)
# %B (%b) = 太字モードの開始 (終了)
# %t or %@ = 12 時間制, am/pm 形式での現在時刻
# %n or $USERNAME = ユーザー ($USERNAME は環境変数なので setopt prompt_subst が必要)
# %N = シェル名
# %i = %N によって与えられるスクリプト, ソース, シェル関数で, 現在実行されている行の番号 (debug用)
# %T = 24 時間制での現在時刻
# %* = 24 時間制での現在時刻, 秒付き
# %w = `曜日-日' の形式での日付
# %W = `月/日/年' の形式での日付
# %D = `年-月-日' の形式での日付
# %D{string} = strftime 関数を用いて整形された文字列 (man 3 strftime でフォーマット指定が分かる)
# %l = ユーザがログインしている端末から, /dev/ プレフィックスを取り除いたもの
# %y = ユーザがログインしている端末から, /dev/ プレフィックスを取り除いたもの (/dev/tty* はソノママ)
# %? = プロンプトの直前に実行されたコマンドのリターンコード
# %_ = パーサの状態
# %E = 行末までクリア
# %# = 特権付きでシェルが実行されているならば `#', そうでないならば `%' == %(!.#.%%)
# %v = psvar 配列パラメータの最初の要素の値
# %{...%} = リテラルのエスケープシーケンスとして文字列をインクルード
# %(x.true-text.false-text) = 三つ組の式
# %<string<, %>string>, %[xstring] = プロンプトの残りの部分に対する, 切り詰めの振る舞い
#         `<' の形式は文字列の左側を切り詰め, `>' の形式は文字列の右側を切り詰めます
# %c, %., %C = $PWD の後ろ側の構成要素


# PROMPT='%{[$[32+$RANDOM % 5]m%}%U%B$HOST'"{`whoami`}%b%%%{[m%}%u " # prompt_subst が必要
# 右プロンプト
# RPROMPT='%{[33m%}[%~]%{[m%}'

#---- その他特殊変数 -------#
HISTFILE=${HOME}/.zsh_history  # ヒストリ保存ファイル
HISTSIZE=10000                    # メモリ内の履歴の数
SAVEHIST=100000                   # 保存される履歴の数
LISTMAX=1000                      # 補完リストを尋ねる数 (1=黙って表示, 0=ウィンドウから溢れるときは尋ねる)

if [ $UID = 0 ]; then             # root のコマンドはヒストリに追加しない
    unset HISTFILE
    SAVEHIST=0
fi


#---- 補完 ---------------#
# cd の後はディレクトリ名のみがマッチする
# su の後はユーザ名のみマッチする
# ssh の直後はユーザ名 or ホスト名、ユーザ名@に続いてはホスト名のみがマッチ(候補ホスト名の登録はまた後々)
# make の後は Makefile に記述されたターゲット名(install など)
# make --PREFIX= などの = の後のフルパス名マッチ
# jobs, fg, bg でのジョブ名マッチ
# kill の後のプロセス ID マッチ
# scp のリモートホスト側で、相手のファイルパスをマッチさせる
# 第1要素が大文字から始まる場合は環境変数にマッチ
# 代表的なコマンドでは 「-」 や 「--」 の後に使用可能なオプションがマッチ
# $の後はシェル変数／環境変数がマッチ(compinit しなくてもできますが)
# - 動的補完 : w3m, gcc 等に応じたファイルのみが補完される
# oh-my-zshがやるからいらない
# autoload -U compinit
# compinit -u

# 補完の時に大文字小文字を区別しない (但し、大文字を打った場合は小文字に変換しない)
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 一部のコマンドライン定義は、展開時に時間のかかる処理を行う
#  apt-get, dpkg (Debian), rpm (Redhat), urpmi (Mandrake), perlの-Mオプション,
#  bogofilter (zsh 4.2.1以降), fink, mac_apps (MacOS X)(zsh 4.2.2以降)
zstyle ':completion:*' use-cache true
# 補完候補を ←↓↑→ で選択 (補完候補が色分け表示される)
zstyle ':completion:*:default' menu select=1
# 補完候補を ←↓↑→ で選択 (補完候補が色分け表示される)
#zstyle ':completion:*:default' menu select true
# オプション補完で解説部分を表示しない
#zstyle :completion:* verbose no
#
# カレントディレクトリに候補がない場合のみ cdpath 上のディレクトリを候補
zstyle ':completion:*:cd:*' tag-order local-directories path-directories

# 特定のコマンドの補完を無効にする
# compdef -d w3m
# あるコマンドの補完を他のコマンドのように補完する (platex も latex と同じ)
# compdef _tex platex

#---- zmv ---------------#
# autoload -U zmv
# # % zmv '(*).jpeg' '$1.jpg'
# # % zmv '(**/)foo(*).jpeg' '$1bar$2.jpg'
# # % zmv -n '(**/)foo(*).jpeg' '$1bar$2.jpg' # 実行せずパターン表示のみ
# # % zmv '(*)' '${(L)1}; # 大文字→小文字
# # % zmv -W '*.c.org' 'org/*.c' #「(*)」「$1」を「*」で済ませられる
# alias mmv='noglob zmv -W'  # 引数のクォートも面倒なので
# # % mmv *.c.org org/*.c
# #zmv -C # 移動ではなくコピー(zcp として使う方法もあるみたいだけど)
# #zmv -L # 移動ではなくリンク(zln として使う方法もあるみたいだけど)

# 履歴による予測入力 (man zshcontrib)
#autoload -U predict-on
#zle -N predict-on
#zle -N predict-off
#bindkey '^xp' predict-on
#bindkey '^x^p' predict-off

# core抑制
#unlimit
#limit core 0
#limit -s
limit   coredumpsize    0

# ファイル作成時のパーミッション
umask 022

# screen 時に ssh, telnet でログインしたホスト名を window 名にする
if [ "$TERM" = "screen" ]; then
    function ssh() {
        echo -n "^[k$1^[\\"
        /usr/bin/ssh $1
    }
fi

#####################################################################
# key bindings
#####################################################################
# 端末設定
stty    erase   '^H'        # Ctrl+H に 1 文字削除
stty    intr    '^C'        # Ctrl+C に割り込み
stty    susp    '^Z'        # Ctrl+Z にサスペンド

# zsh のキーバインド (EDITOR=vi かでも判断)
bindkey -e    # emacs 風
#zle-line-init() { zle -K vicmd; } ; zle -N zle-line-init # 初期状態をコマンドモード

# カーソル位置から前方削除
# override kill-whole-line
bindkey '^U' backward-kill-line

# 履歴検索 = C-p,n で検索・補完
#autoload -U history-search-end
#zle -N history-beginning-search-backward-end history-search-end
#zle -N history-beginning-search-forward-end history-search-end
#bindkey "^P" history-beginning-search-backward-end
#bindkey "^N" history-beginning-search-forward-end
#bindkey '^P' history-beginning-search-backward
#bindkey '^N' history-beginning-search-forward

# history incremental search
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

# ワイルドカードの展開を確認
#bindkey "^X" expand-word
# ヘルプの表示
#bindkey "^B" run-help
# run-help が呼ばれた時、zsh の内部コマンドの場合は該当する zsh のマニュアル表示
#[ -n "`alias run-help`" ] && unalias run-help
#autoload run-help

# ls /usr/local/etc などと打っている際に、C-w で単語ごとに削除
# default  : ls /usr/local → ls /usr/ → ls /usr → ls /
# この設定 : ls /usr/local → ls /usr/ → ls /
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'


#####################################################################
# functions
#####################################################################
# setopt prompt_subst          # プロンプトに escape sequence (環境変数) を通す
# unsetopt promptcr            # 改行のない出力をプロンプトで上書きするのを防ぐ
#  autoload -U colors        # プロンプトのカラー表示を有効
#  colors                    # → 色指定  $fg[色名]/$bg[色名]/$reset_color (${, $} で囲む必要がある)
#                            #            30黒 31赤 32緑 33黄 34青 35紫 36水 37白

#setopt extended_history      # 履歴ファイルに開始時刻と経過時間を記録
unsetopt extended_history
setopt append_history        # 履歴を追加 (毎回 .zhistory を作るのではなく)
setopt inc_append_history    # 履歴をインクリメンタルに追加
setopt share_history         # 履歴の共有
setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups      # 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_space     # スペースで始まるコマンド行はヒストリリストから削除
                             # (→ 先頭にスペースを入れておけば、ヒストリに保存されない)
unsetopt hist_verify         # ヒストリを呼び出してから実行する間に一旦編集可能を止める
setopt hist_reduce_blanks    # 余分な空白は詰めて記録
setopt hist_save_no_dups     # ヒストリファイルに書き出すときに、古いコマンドと同じものは無視する。
setopt hist_no_store         # historyコマンドは履歴に登録しない

setopt hist_expand           # 補完時にヒストリを自動的に展開
setopt list_packed           # コンパクトに補完リストを表示
#setopt auto_remove_slash     # 補完で末尾に補われた / を自動的に削除
unsetopt auto_remove_slash
setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_types            # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
unsetopt menu_complete       # 補完の際に、可能なリストを表示してビープを鳴らすのではなく、
                             # 最初にマッチしたものをいきなり挿入、はしない
setopt auto_list             # ^Iで補完可能な一覧を表示する(補完候補が複数ある時に、一覧表示)
setopt auto_menu             # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys       # カッコの対応などを自動的に補完
setopt auto_resume           # サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム

# setopt auto_correct          # 補完時にスペルチェック
setopt correct               # スペルミスを補完
setopt correct_all           # コマンドライン全てのスペルチェックをする
# setopt AUTOLOGOUT=n          # n分後に自動的にログアウト

setopt auto_cd               # ディレクトリのみで移動
setopt no_beep               # コマンド入力エラーでBeepを鳴らさない
#setopt beep
setopt brace_ccl             # ブレース展開機能を有効にする
#### setopt bsd_echo         # oh-my-zsh gabaguru
setopt complete_in_word
setopt equals                # =COMMAND を COMMAND のパス名に展開
setopt extended_glob         # 拡張グロブを有効にする
unsetopt flow_control        # (shell editor 内で) C-s, C-q を無効にする
setopt no_flow_control       # C-s/C-q によるフロー制御を使わない
setopt hash_cmds             # 各コマンドが実行されるときにパスをハッシュに入れる
setopt no_hup                # ログアウト時にバックグラウンドジョブをkillしない
setopt ignore_eof            # C-dでログアウトしない
#setopt no_checkjobs          # ログアウト時にバックグラウンドジョブを確認しない

setopt long_list_jobs        # 内部コマンド jobs の出力をデフォルトで jobs -L にする
setopt magic_equal_subst     # コマンドラインの引数で --PREFIX=/USR などの = 以降でも補完できる
setopt mail_warning
setopt multios               # 複数のリダイレクトやパイプなど、必要に応じて TEE や CAT の機能が使われる
setopt numeric_glob_sort     # 数字を数値と解釈してソートする
setopt path_dirs             # コマンド名に / が含まれているとき PATH 中のサブディレクトリを探す
setopt print_eight_bit       # 補完候補リストの日本語を適正表示
setopt short_loops           # FOR, REPEAT, SELECT, IF, FUNCTION などで簡略文法が使えるようになる

setopt auto_name_dirs
#setopt sun_keyboard_hack     # SUNキーボードでの頻出 typo ` をカバーする
setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt cdable_vars sh_word_split

setopt auto_pushd            # 普通に cd するときにもディレクトリスタックにそのディレクトリを入れる
setopt pushd_ignore_dups     # ディレクトリスタックに重複する物は古い方を削除
setopt pushd_to_home         # pushd 引数ナシ == pushd ${HOME}
setopt pushd_silent          # pushd,popdの度にディレクトリスタックの中身を表示しない

#setopt rm_star_wait          # rm * を実行する前に確認
setopt rm_star_silent        # rm * を実行する前に確認しない
setopt notify                # バックグラウンドジョブが終了したら(プロンプトの表示を待たずに)すぐに知らせる

#setopt no_clobber            # リダイレクトで上書きを禁止
unsetopt no_clobber
# setopt no_unset             # 未定義変数の使用禁止
#setopt interactive_comments  # コマンド入力中のコメントを認める
#setopt chase_links           # シンボリックリンクはリンク先のパスに変換してから実行
#setopt print_exit_value      # 戻り値が 0 以外の場合終了コードを表示
#setopt single_line_zle       # デフォルトの複数行コマンドライン編集ではなく、１行編集モードになる
#setopt xtrace                # コマンドラインがどのように展開され実行されたかを表示する
# for nvm
setopt no_nomatch

# カレントディレクトリ中にサブディレクトリが無い場合に cd が検索するディレクトリのリスト
cdpath=(${HOME})
# zsh関数のサーチパス
#fpath=($fpath ~/.zfunc )
