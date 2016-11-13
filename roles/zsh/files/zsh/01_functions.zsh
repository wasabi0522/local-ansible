# あればsourceする
function load-if-exists() { test -e "$1" && source "$1" }

function export-if-exists() {
    if [[ -e "${2}" ]]; then
        # http://d.hatena.ne.jp/kitokitoki/20111123/p1
        if [[ `eval echo '${'${1}'-UNDEF}'` = "UNDEF" ]]; then
            if [ `eval echo '$'${1}` = ""]; then
                export "${1}=${2}"
            fi
        else
            export "${1}=${2}:"`eval echo '$'${1}`
        fi
    fi
}

# cd && ls
function cd () {               # ファイルを探して、そのファイルのある場所にcd
    if [ $# = 0 ]; then        #    % locate something.c
        builtin cd             #        /usr/local/.../something.c
    elif [ -f $1 ]; then       #    % cd `!!`
        builtin cd $1:h
    else
        builtin cd $*
    fi
    ls -aFG
}

# ターミナルのウィンドウ・タイトルを動的に変更
precmd() {
    [[ -t 1 ]] || return
    case $TERM in
        *xterm*|rxvt|(dt|k|E)term)
            print -Pn "\e]2;[%n@%m %~]\a"
            ;;
    esac
}

# rmはtrashに移動
 function rm() {
   if [ -d ~/.trash ]; then
     local DATE=`date "+%y%m%d-%H%M%S"`
     mkdir ~/.trash/$DATE
     for i in $@; do
       # 対象が ~/.trash/ 以下なファイルならば /bin/rm を呼び出したいな
       if [ -e $i ]; then
         mv $i ~/.trash/$DATE/
       else
         echo "$i : not found"
       fi
     done
   else
     /bin/rm $@
   fi
 }

function git(){hub "$@"} # zsh
