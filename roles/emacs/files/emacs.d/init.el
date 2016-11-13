;;; cask

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "/usr/local/Cellar/cask/0.8.1/")

(require 'cask)
(cask-initialize)

;;; pallet
(require 'pallet)
(pallet-mode t)

;;; init-loader.el
(require 'init-loader)
(init-loader-load "~/.emacs.d/conf")
