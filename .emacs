
;; roridev's .emacs config
;; Made on May 2021
;; I really want to get into emacs lel.


;; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)


;; Disabling  D e c o r a t o r s
(menu-bar-mode -1)
(tool-bar-mode -1)

;; ISO-translation [For ABNT layout support]
(require 'iso-transl)

;; Language Server Protocol
(require 'lsp-mode)

(require 'lsp-haskell)

(require 'lsp-python-ms)
(setq lsp-python-ms-auto-install-server t)



;; Global Modes
(global-display-line-numbers-mode)
(global-flycheck-mode)
(pending-delete-mode)
(add-hook 'after-init-hook 'global-company-mode)
(company-quickhelp-mode)


;; Expand Regions
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; Haskell
(add-hook 'haskell-mode-hook 'haskell-interactive-mode)
(add-hook 'haskell-mode-hook 'haskell-doc-mode)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(add-hook 'haskell-mode-hook 'flycheck-haskell)
;; (add-hook 'haskell-mode-hook 'stack-mode)
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)

;; Dotnet
(add-hook 'csharp-mode-hook #'lsp)

;; Python
(add-hook 'python-mode-hook #'lsp)

;; From omnisharp/omnisharp-emacs

;; End of omnisharp/omnisharp-emacs

(add-hook 'csharp-mode-hook #'company-mode)
(add-hook 'csharp-mode-hook #'flycheck-mode)

;; Font
(set-frame-font "Jetbrains Mono-10" nil t)

					;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					; Things emacs generates automatically ;
					; so i'm not messing with it~~~~       ;
					;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Custom
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(company-quickhelp-color-background "#44475a")
 '(company-quickhelp-color-foreground "#f8f8f2")
 '(company-quickhelp-mode t)
 '(custom-enabled-themes '(dracula))
 '(custom-safe-themes
   '("824d07981667fd7d63488756b6d6a4036bae972d26337babf7b56df6e42f2bcd" default))
 '(package-selected-packages
   '(treemacs lsp-python-ms lsp-ui lsp-haskell yasnippet lsp-mode python-mode magit dracula-theme company-quickhelp csharp-mode rainbow-mode expand-region flycheck-haskell ## stack-mode company-cabal company-ghci company haskell-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
