(require 'package)

(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
;;(require 'diminish)
;;(require 'bind-key)

(use-package dracula-theme 
  :ensure t
  :init (load-theme 'dracula t))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(doom-modeline lsp-pyright lsp-ivy lsp-ui lsp-treemacs company hasklig-mode lsp-haskell haskell-mode company-mode flycheck which-key lsp-mode dracula-theme use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (XXX-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)(use-package lsp-mode
		  :ensure t)

(use-package lsp-ui
	     :ensure t
	     :commands lsp-ui-mode)
(use-package lsp-ivy
	     :ensure t
	     :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :ensure t)

;; optional if you want which-key integration
(use-package which-key
    :config
    (which-key-mode)
    :ensure t)

(use-package flycheck :ensure t)
(use-package company :ensure t)

;; Haskell
(use-package haskell-mode :ensure t)
(use-package lsp-haskell :ensure t)
;; Hooks so haskell and literate haskell major modes trigger LSP setup
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)

(set-face-attribute 'default nil
                    :family "Hasklig"
                    :height 100
                    :weight 'normal
                    :width 'normal)

(use-package hasklig-mode
  :hook (haskell-mode)
  :ensure t)

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))
