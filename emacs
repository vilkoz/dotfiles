;;; package --- Summary
;;; Commentary:
;;; Code:
(custom-set-variables
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
'(custom-enabled-themes (quote (tango-dark)))
'(package-selected-packages
(quote
(relative-line-numbers helm evil-search-highlight-persist evil))))
(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
)
;; packages
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			("org" . "http://orgmode.org/elpa/")
			("marmalade" . "http://marmalade-repo.org/packages/")
			("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")))
(add-to-list 'package-archives
			 '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(defun require-package (package)
	(setq-default highlight-tabs t)
	"Install given PACKAGE."
	(unless (package-installed-p package)
	(unless (assoc package package-archive-contents)
		(package-refresh-contents))
	(package-install package)))

;; evil-mode enable
(require 'evil)
(evil-mode 1)

;; emacs-powerline
(add-to-list 'load-path "~/.emacs.d/vendor/emacs-powerline")
(require 'powerline)

;; vim-like search highlight
(require 'evil-search-highlight-persist)
(global-evil-search-highlight-persist t)

;; rnu
(add-hook 'prog-mode-hook 'relative-line-numbers-mode t)
(add-hook 'prog-mode-hook 'line-number-mode t)
(add-hook 'prog-mode-hook 'column-number-mode t)

;; set theme
(load-theme 'wheatgrass)

;; indentiation
(setq-default indent-tabs-mode t)
(setq-default tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(setq indent-line-function 'insert-tab)
(setq c-default-style "linux")

;; disable scroll-bar
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; gdb stuff
(setq gdb-many-windows t)

;; matching parenthesis
(require 'autopair)
(autopair-global-mode)
(require 'paren)
(show-paren-mode 1)
(setq show-paren-delay 0)
(set-face-background 'show-paren-match (face-background 'default))
(set-face-foreground 'show-paren-match "#def")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

;; syntax check flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable splash
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)

(provide '.emacs)
;;; .emacs ends here
