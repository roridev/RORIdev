
;; roridev's .emacs config
;; Made on May 2021
;; I really want to get into emacs lel.


;; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; QUELPA
(require 'quelpa)

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

(require 'lsp-java)

;; Latex
(require 'ox-latex)

(setq org-latex-listings 'minted)

(add-to-list 'org-latex-packages-alist '("" "listings"))
(add-to-list 'org-latex-packages-alist '("" "color"))

(setq org-latex-minted-options
      '(("breaklines" "")
	("mathescape" "")
	("linenos" "")
	("numbersep" "5pt")
	("frame" "single")
	("xleftmargin" "0pt")))

(setq org-latex-tables-centered t)

(setq org-latex-pdf-process
      '("lualatex --shell-escape %f")
      )
;; centaur-tabs
(require 'centaur-tabs)
(global-set-key (kbd "C-<prior>") 'centaur-tabs-backward)
(global-set-key (kbd "C-<next>") 'centaur-tabs-forward)
(centaur-tabs-headline-match)
(setq centaur-tabs-style "bar")
(setq centaur-tabs-set-icons t)

(setq centaur-tabs-set-bar 'under)
(setq x-underline-at-descent-line t)

;; elcord
(require 'elcord)
(elcord-mode)

;; org
(require 'org-make-toc)

;; Global Modes
(global-display-line-numbers-mode)
(global-flycheck-mode)
(pending-delete-mode)
(add-hook 'after-init-hook 'global-company-mode)
(company-quickhelp-mode)
(editorconfig-mode)
(centaur-tabs-mode)

;; MediaWiki
(require 'mediawiki)
(setq mediawiki-site-alist
      (append '(("PowerNukkit" "https://powernukkit.fandom.com" "roridev" "Bol0sa10" "Main Page"))
	      mediawiki-site-alist))

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
(add-hook 'csharp-mode-hook #'company-mode)
(add-hook 'csharp-mode-hook #'flycheck-mode)

;; Python
(add-hook 'python-mode-hook #'lsp)

;; Java
(add-hook 'java-mode-hook #'lsp)

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
 '(custom-enabled-themes '(idea-darkula))
 '(custom-safe-themes
   '("5a04c3d580e08f5fc8b3ead2ed66e2f0e5d93643542eec414f0836b971806ba9" "824d07981667fd7d63488756b6d6a4036bae972d26337babf7b56df6e42f2bcd" default))
 '(package-selected-packages
   '(centaur-tabs idea-darkula-theme htmlize mediawiki org-make-toc elcord quelpa editorconfig lsp-java java-imports treemacs lsp-python-ms lsp-ui lsp-haskell yasnippet lsp-mode python-mode magit dracula-theme company-quickhelp csharp-mode rainbow-mode expand-region flycheck-haskell ## stack-mode company-cabal company-ghci company haskell-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
