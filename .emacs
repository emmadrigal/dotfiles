
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (vs-dark)))
 '(custom-safe-themes
   (quote
    ("4417913061aa6623f89864e32fc1ab2b03a41bfb37320fe98821d6a0af7883be" default)))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (vs-dark-theme acme-theme python-docstring meson-mode cuda-mode fira-code-mode flycheck-pycheckers flymake-cppcheck flymake-python-pyflakes ace-window gh-md latex-math-preview latex-extra ac-octave markdown-mode imenus hideshow-org dts-mode nov yasnippet-snippets auto-complete-auctex flycheck-ini-pyinilint flycheck-irony flycheck))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; If something is selected and something is written, the selection is deleted
(delete-selection-mode 1)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                        ("marmalade" . "https://marmalade-repo.org/packages/")
                        ("melpa" . "https://melpa.org/packages/")))

;; Enlarge and squish windows
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)


;; Autocomplete on LaTeX mode
(require 'package)
(package-initialize)

;; yasnippet code 'optional', before auto-complete
(require 'yasnippet)
(yas-global-mode 1)

;; auto-complete setup, sequence is important
(require 'auto-complete)
(add-to-list 'ac-modes 'latex-mode) ; beware of using 'LaTeX-mode instead
(require 'ac-math) ; package should be installed first 
(defun my-ac-latex-mode () ; add ac-sources for latex
   (setq ac-sources
         (append '(ac-source-math-unicode
           ac-source-math-latex
           ac-source-latex-commands)
                 ac-sources)))
(add-hook 'LaTeX-mode-hook 'my-ac-latex-mode)
(setq ac-math-unicode-in-math-p t)
(ac-flyspell-workaround) ; fixes a known bug of delay due to flyspell (if it is there)
(add-to-list 'ac-modes 'org-mode) ; auto-complete for org-mode (optional)
(require 'auto-complete-config) ; should be after add-to-list 'ac-modes and hooks
(ac-config-default)
(setq ac-auto-start nil)            ; if t starts ac at startup automatically
(setq ac-auto-show-menu t)
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")  
(global-auto-complete-mode t) 

(setq column-number-mode t)

;; -*- mode: elisp -*-

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

;; Enable transient mark mode
(transient-mark-mode 1)

;;;;Org mode configuration
;; Enable Org mode
(require 'org)

(setq org-agenda-files (list "~/mynotes/maestria.org"
                             "~/mynotes/roya.org" 
                             "~/mynotes/work.org"))

(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))

(autoload 'latex-math-preview-expression "latex-math-preview" nil t)
(autoload 'latex-math-preview-insert-symbol "latex-math-preview" nil t)
(autoload 'latex-math-preview-save-image-file "latex-math-preview" nil t)
(autoload 'latex-math-preview-beamer-frame "latex-math-preview" nil t)

;; Disable menu bar
(menu-bar-mode -1)

;; Disable tool bar
(tool-bar-mode -1)
(put 'upcase-region 'disabled nil)

;; Ace  Windows
(global-set-key (kbd "M-o") 'ace-window)


;; Automatically load irony mode when working with C/C++
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
 
;; Load Yasnippet after load
(add-hook 'c++-mode-hook 'yas-minor-mode)
(add-hook 'c-mode-hook 'yas-minor-mode)
(add-hook 'objc-mode-hook 'yas-minor-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
 (define-key irony-mode-map [remap completion-at-point]
   'irony-completion-at-point-async)
 (define-key irony-mode-map [remap complete-symbol]
   'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
 
;; Auto load company on startup
(add-hook 'after-init-hook 'global-company-mode)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))
 
;; Load flycheck irony on startup
(add-hook 'after-init-hook 'global-flycheck-mode)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))


