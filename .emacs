
;; roridev's portable .emacs config
;; Made on Feb 2022
;; I really want to get into emacs lel.

;; Requires: use-package
;; Install use-package from MELPA
;; Then load the .emacs

;;; Package Configuration
(require 'package)

;;; Package - Add Melpa
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;;; Package - Initialization
(package-initialize)

;;; UTF-8

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-language-environment 'utf-8)

;;;;;;;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  )


(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe)
  )

(use-package company)
(use-package company-quickhelp)

(use-package lsp-mode)

(use-package lsp-ui
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))


(use-package lsp-haskell)
(use-package rustic
  :bind (:map rustic-mode-map
	      ("M-j" . lsp-ui-imenu)
	      ("M-?" . lsp-find-references)
	      ("C-c C-c l" . flycheck-list-errors)
	      ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  (setq rustic-format-trigger 'on-save)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  )

(use-package toml-mode)


(use-package psc-ide)



(use-package haskell-mode)
(use-package purescript-mode)


(use-package elcord)
(use-package flycheck)
(use-package expand-region
  :config
  (global-set-key (kbd "C-=") 'er/expand-region)
  )

(use-package dracula-theme)

(use-package centaur-tabs
  :config
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-set-bar 'under)
  (setq x-underline-at-descent-line t)
  )

(use-package auctex
  :config
  (setq TeX-PDF-mode t)
  (setq TeX-engine 'luatex)
  )


;;;;;;;; Themes / Fonts
(load-theme 'dracula t)

(add-to-list 'default-frame-alist '(font . "Jetbrains Mono-10"))
(set-face-attribute 'default nil :font "Jetbrains Mono-10")

;;;;;;;;; Modes


;;; Remoção de Decorações
(menu-bar-mode -1)
(tool-bar-mode -1)

(elcord-mode)

(global-flycheck-mode)
(global-display-line-numbers-mode)

(company-quickhelp-mode)

(centaur-tabs-mode)

;;;;;;;;; Hooks

(add-hook 'after-init-hook 'global-company-mode)

;;;;;;;;;;;;;; Haskell Hooks

(add-hook 'haskell-mode-hook 'haskell-interactive-mode)
(add-hook 'haskell-mode-hook 'haskell-doc-mode)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(add-hook 'haskell-mode-hook 'flycheck-haskell)
;; (add-hook 'haskell-mode-hook 'stack-mode)
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)


(add-hook 'purescript-mode-hook
	  (lambda ()
	    (psc-ide-mode)
	    (company-mode)
	    (flycheck-mode)
	    (turn-on-purescript-indentation)))


;;;;;;;;;;; CUSTOM ;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(magit use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

