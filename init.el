;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(blink-cursor-mode nil)
 '(hippie-expand-try-functions-list
   '(try-complete-file-name-partially try-complete-file-name
                                      try-expand-all-abbrevs
                                      try-expand-dabbrev
                                      try-expand-dabbrev-from-kill
                                      try-expand-dabbrev-all-buffers
                                      try-complete-lisp-symbol-partially
                                      try-complete-lisp-symbol
                                      try-expand-list try-expand-line))
 '(inhibit-default-init nil)
 '(inhibit-startup-screen t)
 '(modus-operandi-tinted-palette-overrides '((red "#ff0000")))
 '(package-selected-packages
   '(company counsel dashboard doom-modeline evil evil-visual-mark-mode
             fireplace ivy ivy-rich lsp-mode magit multiple-cursors
             org-bullets org-habit-stats persist slime swiper tldr tp
             typescript-mode use-package))
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 145 :width normal :foundry "JB" :family "JetBrains Mono"))))
 '(cursor ((t (:background "tomato")))))

(use-package vterm
  :defer t
  :ensure t
  :config
  (setq vterm-shell "/usr/bin/fish"))

(use-package ivy
  :defer t
  :ensure t
  :config
  (ivy-rich-mode)
  (counsel-mode)
  (setq ivy-initial-inputs-alist nil) ;; no leading ^ pls
  (keymap-global-set "C-x b" 'counsel-ibuffer))

(use-package multiple-cursors
  ;; :defer t
  :ensure t
  :config
  (keymap-global-set "C-." 'mc/mark-next-like-this)
  (keymap-global-set "C-," 'mc/mark-previous-like-this)
  (keymap-global-set "C->" 'mc/mark-all-like-this))

(use-package package
  :defer t
  :config
  (setq package-archives '(("melpa" . "https://melpa.org/packages/")
			   			   ("elpa" . "https://elpa.gnu.org/packages/")
						   ("org" . "https://orgmode.org/elpa/")
						   ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
  (package-initialize))

(use-package all-the-icons
  ;; :defer t ;; dont defer to make emacsclient load faster
  :ensure t
  :if (display-graphic-p))

(use-package dashboard
  ;; :defer t ;; dont defer because loading this at boot makes emacsclient faster
  :ensure t
  :config
  (setq dashboard-banner-logo-title "home sweet emacs")
  ;; (setq dashboard-startup-banner )
  (setq dashboard-center-content t)
  (setq dashboard-vertically-center-content t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-icon-type 'all-the-icons)
  (setq dashboard-items '((agenda . 5)
	                      (recents . 7)))
  (setq dashboard-item-shortcuts '((recents . "f")
								   (agenda . "s")))
  (setq dashboard-footer-messages
        '("success")))

(use-package org
  :defer t
  :config
  (add-hook 'org-mode-hook 'org-bullets-mode)
  (add-hook 'org-mode-hook
		    (lambda ()
			  (local-set-key "C-j" 'next-line)
			  (local-set-key "C-k" 'previous-line)))
  (setq org-agenda-files
	    '("~/org/agenda"))
  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-into-drawer t)
  (setq org-todo-keywords
	    '((sequence "TODO(t)" "CURRENT(c)" "URGENT(u)" "DEFERRED(f)" "MAYBE(m)" "ASSIGNMENT(a)" "|" "DONE(d)" "NOTDOING(n)"))))

(use-package tramp
  :defer t
  :config
  (setq backup-enable-predicate
        (lambda (name)
          (and (normal-backup-enable-predicate name)
               (not
                (let ((method (file-remote-p name 'method)))
                  (when (stringp method)
                    (member method '("su" "sudo"))))))))
  (keymap-global-set "C-x M-r" 'tramp-cleanup-all-buffers))

(use-package fireplace
  :defer t
  :ensure t)

(use-package doom-modeline
  :defer t
  :ensure t
  :init
  (setq doom-modeline-icon nil)
  (setq doom-modeline-time t)
  (setq doom-modeline-time-analogue-clock t)
  (setq display-time-format "%H:%M %a %d/%m(%b)")
  (setq display-time-default-load-average nil)
  (setq doom-modeline-battery t)
  (display-battery-mode)
  (display-time)
  (doom-modeline-mode))

(use-package tab-bar
  :defer t
  :config
  (setq tab-bar-format nil)
  (keymap-set tab-prefix-map "1" #'(lambda ()
                                     (interactive)
                                     (tab-close-other)
                                     (tab-bar-mode 0)))
  (keymap-set tab-prefix-map "l" #'(lambda ()
                                     (interactive)
                                     (message (format "num of tabs: %s" (length (tab-bar-tabs))))))
  (keymap-global-set "C-S-t" 'tab-bar-undo-close-tab))

(use-package recentf
  :defer t
  :config
  (keymap-global-set "C-x j M-r" '(lambda()
                                    (interactive)
                                    (split-window-vertically)
                                    (other-window)
                                    (recentf-open))))
  ;; (keymap-global-set "")

(use-package use-package
  :init
  (setq use-package-always-defer t))

(use-package emacs
  :init
  (setq use-short-answers t ;; answer with y or n
        confirm-kill-emacs 'yes-or-no-p) ;; also y or n
  :config
  (load-file "~/.emacs.d/cornell.el")
  (load-file "~/.emacs.d/conv-org.el")
  (load-theme 'modus-operandi-tinted)
  (setq initial-scratch-message "")
  
  (set-fringe-mode 0)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (tooltip-mode -1)
  (menu-bar-mode -1)
  (blink-cursor-mode 0)
  (setq scroll-conservatively 100)

  (doom-modeline-mode)
  (ivy-mode)
  ;; (multiple-cursors-mode)
  (electric-pair-mode)

  (setq package-quickstart t)

  (keymap-global-set "C-x j r" 'recentf-open)
  (keymap-global-set "C-x M-f" 'find-file-other-window)

  (setq-default tab-stop-list 4)
  (setq-default indent-tab-modes nil)
  (setq-default tab-always-indent nil)
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4)
  (setq-default c-basic-offset 4)
  (setq indent-line-function 'insert-tab)
  (defvaralias 'c-basic-offset 'tab-width)
  (setq split-width-threshold 1)

  (keymap-global-set "C-=" 'text-scale-increase)
  (keymap-global-set "C--" 'text-scale-decrease)
  (keymap-global-set "C-s" 'swiper)
  (keymap-global-set "C-S-s" 'swiper-thing-at-point)
  (keymap-global-set "C-x f" 'query-replace)
  (keymap-global-set "C-x j c" 'conv/cornell-init)
  (keymap-global-set "C-x j a" 'conv/org-agenda-list)
  (keymap-global-set "C-x j d" 'conv/code-init)
  (keymap-global-set "C-x h" 'previous-buffer)
  (keymap-global-set "C-x l" 'next-buffer)
  (keymap-global-set "C-x C-r" 'tramp-revert-buffer-with-sudo)
  (unbind-key "C-x C-l")
  (keymap-global-set "C-x C-l l" 'count-lines-page)
  (keymap-global-set "C-x C-l p" 'check-parens)

  (keymap-global-set "C-x j u" 'compile)

  (keymap-global-set "C-k" 'kill-whole-line)
  (keymap-global-set "C-x C-a" 'mark-whole-buffer)
  (keymap-global-set "M-D" 'backward-kill-word)
  (keymap-global-set "M-<up>" '(lambda ()
                                 (interactive)
                                 (kill-whole-line)
                                 (previous-line)
                                 (yank)
                                 (previous-line)))
  (keymap-global-set "M-<down>" '(lambda ()
                                   (interactive)
                                   (kill-whole-line)
                                   (next-line)
                                   (yank)
                                   (previous-line)))
  (setq dabbrev-case-distinction t)
  (keymap-global-set "M-/" 'hippie-expand)

  (global-display-line-numbers-mode t)
  ;; not in some modes please
  (dolist (mode '(term-mode-hook
				  shell-mode-hook
                  vterm-mode-hook
				  eshell-mode-hook
	  			  fireplace-mode-hook))
	(add-hook mode (lambda () (display-line-numbers-mode 0))))
  (global-hl-line-mode)
  (keymap-global-set "M-p" '(lambda () (interactive) (hl-line-mode 'toggle)))
  (dolist (mode '(vterm-mode-hook
                  dashboard-mode-hook))
    (add-hook mode (lambda () (hl-line-mode 'toggle)))))
