;; Stan's emacs init file for the mac

;; Path
(add-to-list 'exec-path "/usr/local/bin")

;; Packages
(require 'package)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)
(setq package-enable-at-startup nil)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq user-full-name "Stanislas Nanchen"
      user-mail-address "stan@codesmith.ch")

;; Emacs General settings

(defun stanhbb-ensure-dir! (dirname)
  (unless (file-exists-p dirname)
    (make-directory dirname)))

(defconst stanhbb-savefile-dir (expand-file-name "savefile" user-emacs-directory))

(stanhbb-ensure-dir! stanhbb-savefile-dir)

;; appearance
(blink-cursor-mode 0)
(setq-default cursor-type 'bar)

(tool-bar-mode -1)

;; disable startup screen
(setq inhibit-startup-screen t)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

(setq visible-bell nil)
(setq ring-bell-function 'ignore)

(delete-selection-mode +1)

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; Emacs modes typically provide a standard means to change the
;; indentation width -- eg. c-basic-offset: use that to adjust your
;; personal indentation width, while maintaining the style (and
;; meaning) of any files you load. TODO@Stan learn about that.
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq require-final-newline t)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(global-auto-revert-mode t)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(set-face-attribute 'default nil :font "PragmataPro Mono" :height 150)

;; hippie expand is dabbrev expand on steroids
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))

;; Keybinding

;; Goals are:
;; 1. Usuall mac shortcuts should be respected
;; 2. Use only command + shift to have windows/linux equivalent without too much hassle (since I would bind the command key to control)
;;    For this, I have to make sure that the command key is not linked to meta.
;; 3. Use evil mode + long sequences instead of chords
;; 4. Use F keys without modifiers + plan for layers with key sequences instead of chords, making the chords optional and without meta or control.
;; 5. On mac, control can still be used for terminal stuff
;; 6. Avoid esc since it is not on the home row.
;; 7. Since I use only the command key on the left, there should be not key there
;;    extension of the index finger, but to paste.
(setq mac-command-modifier 'super)

(global-set-key (kbd "s-s") 'save-buffer)
(global-set-key (kbd "s-o") 'find-file)
(global-set-key (kbd "s-,") 'execute-extended-command)
(global-set-key (kbd "s-k") 'switch-to-buffer)
(global-set-key (kbd "s-K") 'ibuffer)
(global-set-key (kbd "s-x") 'kill-region)
(global-set-key (kbd "s-c") 'kill-ring-save)
(global-set-key (kbd "s-v") 'yank)
(global-set-key (kbd "s-a") 'mark-whole-buffer)
(global-set-key (kbd "s-z") 'undo)
(global-set-key (kbd "s-i") 'indent-region)
(global-set-key (kbd "s-f") 'isearch-forward)
(global-set-key (kbd "s-y") 'hippie-expand)
(global-set-key (kbd "s-h") 'help-command)
(global-set-key (kbd "s-!") 'delete-other-windows)
(global-set-key (kbd "s-@") 'split-window-below)
(global-set-key (kbd "s-#") 'split-window-right)

(define-key key-translation-map (kbd "s-e") (kbd "C-g"))

;; Use Package to ensure, load and configure packages.

(require 'use-package)
(setq use-package-verbose t)

(use-package paren
  :config
  (show-paren-mode +1))

(use-package elec-pair
  :config
  (electric-pair-mode +1))

(use-package calendar
  :config
  ;; weeks in Switzerland start on Monday
  (setq calendar-week-start-day 1))

;; saveplace remembers your location in a file when saving files
(use-package saveplace
  :config
  (setq save-place-file (expand-file-name "saveplace" stanhbb-savefile-dir))
  ;; activate it for all buffers
  (setq-default save-place t))

(use-package recentf
  :config
  (setq recentf-save-file (expand-file-name "recentf" stanhbb-savefile-dir)
        recentf-max-saved-items 500
        recentf-max-menu-items 15
        ;; disable recentf-cleanup on Emacs start, because it can cause
        ;; problems with remote files
        recentf-auto-cleanup 'never)
  (recentf-mode +1)
  :bind ("s-O" . recentf-open-files))

(use-package lisp-mode
  :config
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))

(use-package dired
  :config
  (setq dired-use-ls-dired t
        insert-directory-program "/usr/local/bin/gls"
        dired-listing-switches "-aBhl --group-directories-first"))


;; third party

(use-package easy-kill
  :ensure t
  :config
  (global-set-key [remap kill-ring-save] 'easy-kill))

(use-package anzu
  :ensure t
  :bind (("M-%" . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp))
  :config
  (global-anzu-mode))

(use-package rainbow-delimiters
  :ensure t)

(use-package diminish
  :ensure t
  :config
  (diminish 'abbrev-mode)
  (diminish 'flyspell-mode)
  (diminish 'flyspell-prog-mode)
  (diminish 'eldoc-mode))

(use-package markdown-mode
  :ensure t)

(use-package magit
  :ensure t)

(use-package git-timemachine
  :ensure t)

(use-package ag
  :ensure t)

(use-package projectile
  :ensure t
  :init
  (setq projectile-project-search-path '("~/Projects/" "~/Engineering/"))
  :bind ("s-p" . 'projectile-command-map)
  :config
  (projectile-mode +1))

(use-package paredit
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook #'paredit-mode)
  ;; enable in the *scratch* buffer
  (add-hook 'lisp-interaction-mode-hook #'paredit-mode)
  (add-hook 'ielm-mode-hook #'paredit-mode)
  (add-hook 'lisp-mode-hook #'paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'paredit-mode)
  (diminish 'paredit-mode "()"))

(use-package expand-region
  :ensure t
  :bind
  ("A-<up>" . er/expand-region)
  ("A-<down>" . er/contract-region))

(use-package move-text
  :ensure t
  :bind
  (("s-<up>" . move-text-up)
   ("s-<down>" . move-text-down)))

(use-package clojure-mode
  :ensure t
  :config
  ;; teach clojure-mode about some macros that I use on projects like
  ;; nREPL and Orchard
  ;; (define-clojure-indent
  ;;   (returning 1)
  ;;   (testing-dynamic 1)
  ;;   (testing-print 1))
  (add-hook 'clojure-mode-hook #'paredit-mode)
  (add-hook 'clojure-mode-hook #'subword-mode)
  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode))

(use-package inf-clojure
  :ensure t
  :config
  (add-hook 'inf-clojure-mode-hook #'paredit-mode)
  (add-hook 'inf-clojure-mode-hook #'rainbow-delimiters-mode))

(use-package cider
  :ensure t
  :config
  (setq nrepl-log-messages t)
  (setq clojure-toplevel-inside-comment-form t)
  (add-hook 'cider-repl-mode-hook #'paredit-mode)
  (add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode))

(use-package flycheck-joker
  :ensure t)

(use-package web-mode
  :ensure t
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2)
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode)))

(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'" . gfm-mode)
         ("\\.markdown\\'" . gfm-mode))
  :config
  (setq markdown-fontify-code-blocks-natively t))

(use-package yaml-mode
  :ensure t)

(use-package selectrum
  :ensure t
  :config
  (selectrum-mode +1))

(use-package selectrum-prescient
  :ensure t
  :config
  (selectrum-prescient-mode +1)
  (prescient-persist-mode +1))

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.5)
  (setq company-show-numbers t)
  (setq company-tooltip-limit 10)
  (setq company-minimum-prefix-length 2)
  (setq company-tooltip-align-annotations t)
  ;; invert the navigation direction if the the completion popup-isearch-match
  ;; is displayed on top (happens near the bottom of windows)
  (setq company-tooltip-flip-when-above t)
  (global-company-mode)
  (diminish 'company-mode))

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

;; (use-package flycheck-eldev


(use-package hl-todo
  :ensure t
  :config
  (setq hl-todo-highlight-punctuation ":")
  (global-hl-todo-mode))

(use-package undo-tree
  :ensure t
  :config
  ;; autosave the undo-tree history
  (setq undo-tree-history-directory-alist
        `((".*" . ,temporary-file-directory)))
  (setq undo-tree-auto-save-history t)
  (global-undo-tree-mode +1)
  (diminish 'undo-tree-mode))

(use-package ace-window
  :ensure t
  :config
  (global-set-key (kbd "s-t") 'ace-window)
  (global-set-key [remap other-window] 'ace-window))

;; (use-package zop-to-char
;;   :ensure t
;;   :bind (("M-z" . zop-up-to-char)
;;          ("M-Z" . zop-to-char)))

;; ;; ivy

;; (use-package ivy
;;   :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ace-window undo-tree hl-todo flycheck-eldev selectrum-prescient selectrum yaml-mode web-mode flycheck-joker inf-clojure anzu easy-kill expand-region paredit rainbow-delimiters rainbow-delimiter projectile ag git-timemachine diminish use-package markdown-mode magit ivy company cider)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
