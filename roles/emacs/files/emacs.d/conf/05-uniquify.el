;;; uniquify.el
;;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")
(setq uniquify-min-dir-content 1)
