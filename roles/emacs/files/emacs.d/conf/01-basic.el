; キーの設定
; もし、システムが Mac のとき
(when (eq system-type 'darwin)
  ; コントロールキーを Mac ではなく Emacs に渡す
  (setq mac-pass-control-to-system t))
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;;;; emacs本体の設定
;; language
(set-language-environment "Japanese")

;; character-code
(setq default-buffer-file-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'utf-8-unix)
(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(prefer-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8-unix)
(set-file-name-coding-system 'utf-8)

;; behavior
(setq default-directory "~/")                            ; 初期ディレクトリを設定
(setq kill-whole-line t)                                 ; C-kで改行も切り取る
(setq x-select-enable-clipboard t)                       ; killringとクリップボードを同期する
(setq dabbrev-case-fold-search nil)                      ; 動的管にて大文字・小文字を区別する
(add-hook 'before-save-hook 'delete-trailing-whitespace) ; 保存時に無駄なスペースを削除
(keyboard-translate ?\C-h ?\C-?)
;; (global-set-key "\C-h" 'delete-backward-char)            ; C-h にBackspaceを割り当て
(setq auto-coding-functions nil)                         ; HTMLのMETAタグコーディング無視

(setq completion-ignore-case t)                          ; file名の補完で大文字小文字を区別しない
(fset 'yes-or-no-p 'y-or-n-p)                            ; yes-noの選択肢をy-nにする
(setq gc-cons-threshold (* 10 gc-cons-threshold))        ; GCを減らして軽くする
(global-auto-revert-mode 1)                              ; 自動再読み込み
(setq debug-on-error nil)                                ; debug用
(setq vc-follow-symlinks t)                              ; symlinkは必ず追いかける
(setq require-final-newline t)                           ; 最後に改行を入れる
(setq message-log-max 10000)                             ; ログの記録行数を増やす

; Autosaveファイルの場所指定
(setq auto-save-list-file-prefix (expand-file-name "~/.emacs.d/autosave/"))
; Backup fileの場所指定
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
            backup-directory-alist))

; サーバ起動
(require 'server)
(unless (server-running-p)
  (server-start))

;;;クライアントを終了するとき終了するかどうかを聞かない
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;;; ウインドウの透明化
(setq default-frame-alist
      (append (list
               '(alpha . (90 50))
               ) default-frame-alist))

; ubulog: Emacsの保存関係の設定
; http://ubulog.blogspot.com/2008/10/emacs.html
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; 2008-07-22 - Learning to be Me
;; http://d.hatena.ne.jp/bubbles/20080722
;; this is mac only
(defun my-mac-toggle-max-window ()
  (interactive)
  (if (frame-parameter nil 'fullscreen)
      (set-frame-parameter nil 'fullscreen nil)
    (set-frame-parameter nil 'fullscreen 'fullboth)))
(global-set-key "\C-cm" 'my-mac-toggle-max-window)

(setq-default tab-width 4 indent-tabs-mode nil)
(setq mac-command-key-is-meta t)

;; http://pokutuna.hatenablog.com/entry/20111117/1321523457
;; 行末のwhitespaceを削除
(setq delete-trailing-whitespace-exclude-patterns (list "\\.md$" "\\.markdown$"))

(require 'cl)
(defun delete-trailing-whitespace-with-exclude-pattern ()
  (interactive)
  (cond ((equal nil (loop for pattern in delete-trailing-whitespace-exclude-patterns
                          thereis (string-match pattern buffer-file-name)))
         (delete-trailing-whitespace))))

(add-hook 'before-save-hook 'delete-trailing-whitespace-with-exclude-pattern)

;; yancya / init.el
;; https://gist.github.com/yancya/4475969
;; Ctrl+TAB で次のバッファーへ移動する
(global-set-key (kbd "<C-tab>") 'next-buffer)
(global-set-key (kbd "<C-S-tab>") 'previous-buffer)

;; clipboard for mac
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

;; 年末emacs設定大掃除をして、これは捨てられないと思った設定書いてく
;; http://blog.shibayu36.org/entry/2012/12/29/001418
;; (global-auto-revert-mode 1)
