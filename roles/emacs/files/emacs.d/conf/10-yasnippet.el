(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/mysnippets"  ;; 自作スニペット
        yas-installed-snippets-dir         ;; package に最初から含まれるスニペット
        ))
(push '("emacs.+/snippets/" . snippet-mode) auto-mode-alist)
(yas-global-mode 1)
