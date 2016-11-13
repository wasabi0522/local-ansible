(setq initial-scratch-message "")                ; scratchバッファの初期メッセージを消す
(setq next-line-add-newlines nil)                ; ファイルの終端で勝手に新しい行を作る
(setq next-screen-context-lines 1)               ; C-v/M-vで前のページの１行を残す
(setq scroll-step 1)                             ; １行ずつスクロール
(setq-default show-trailing-whitespace t)        ; 行末の不要なスペースを強調表示する
(setq-default tab-width 4)                       ; タブ幅
(setq-default indent-tabs-mode nil)              ; インデントにタブを使わない
(display-time-mode 1)                            ; 時刻を表示
(setq display-time-24hr-format t)                ; 24時間表示
(show-paren-mode t)                              ; 対応する括弧を光らせる
(setq inhibit-startup-message t)                 ; スタートアップメッセージを非表示
(size-indication-mode t)                         ; ファイルサイズを表示
(tool-bar-mode -1)                               ; ツールバーを消す
(menu-bar-mode -1)                               ; ツールバーを消す
;; (scroll-bar-mode 0)                           ; スクロールバーを消す
(blink-cursor-mode 0)                            ; カーソルの点滅を止める
(column-number-mode t)                           ; カーソルの位置が何文字目かを表示する
(line-number-mode t)                             ; カーソルの位置が何行目かを表示する
(setq make-pointer-invisible t)                  ; キータイプ中マウスカーソルを消す
(setq-default indicate-empty-lines t)            ; EOFをわかりやすく表示
(setq-default indicate-buffer-boundaries 'right) ;
(setq delete-by-moving-to-trash t)               ; ファイルを削除したらゴミ箱にいれる。
(setq transient-mark-mode t)                     ; リージョンをハイライト

;; カーソル行の背景色を変更(なぜか下線はNG
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "blue"))
    (((class color)
      (background light))
     (:background "ForestGreen"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)

;; 行番号 for emacs23 or later
;; http://masutaka.net/chalow/2009-10-25-1.html
(global-linum-mode t)
(setq linum-format "%4d  ")

;;; スクロールを一行ずつにする
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)

;;タブの代わりに半角スペースを使う
(setq-default tab-width 4 indent-tabs-mode nil)

;; ￥の代わりにバックスラッシュ
(define-key global-map [?¥] [?\\])

(load-theme 'atom-dark t)

(require 'powerline)
(set-face-attribute 'mode-line nil
                    :foreground "#fff"
                    :background "#FF0066"
                    :box nil)

(set-face-attribute 'powerline-active1 nil
                    :foreground "#fff"
                    :background "#FF6699"
                    :inherit 'mode-line)

(set-face-attribute 'powerline-active2 nil
                    :foreground "#000"
                    :background "#ffaeb9"
                    :inherit 'mode-line)
(powerline-default-theme)
