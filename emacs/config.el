;; Emacs Config by Frederico Wieser
;; Updated : 7/6/2023

;;
;; Vanilla Emacs Config
;;

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Add Ruler, where after 80 chars the text is red
(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))

(global-whitespace-mode 1)

;; Use-package to simplify the config file
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure 't)

;; Auto package updating
(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

;; Some Basic Emacs Settings
(scroll-bar-mode 0) ; no scroll bar
(tool-bar-mode 0) ; no tool bar
(menu-bar-mode 0) ; no menu bar
(show-paren-mode 1) ; visualize matching parenthesees
(global-hl-line-mode 1) ; highlight current line
(eldoc-mode 1) ; enable docs in minibuffer
(setq inhibit-startup-screen 1) ; no start screen

;; make tab key do indent first then completion.
(setq-default tab-always-indent 'complete)

;;(global-set-key (kbd "TAB") 'insert-tab)
;;(global-set-key (kbd "<tab>") 'insert-tab)

;; store all backups in a single directory 
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))

;; y or n instead of yes-or no
(fset 'yes-or-no-p 'y-or-n-p)

;; no annoying bell!
(setq ring-bell-function 'ignore)
(setq visible-bell t)

;; set font Hack 15 pt
(set-face-attribute 'default nil
                    :family "Hack"
                    :height 150)

;; when on mac
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta) ; set cmd to meta
  (setq mac-option-modifier nil)
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t)) ; configure title bar
  (add-to-list 'default-frame-alist '(ns-appearance . 'nil)))

;; Have numbered lines
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode t))

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
;;
;; FUN PACKAGES
;;

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)

;; Tangle all files
(let ((posts (directory-files "" t "org$")))
    (dolist (post posts)
      (org-babel-tangle-file post)))

;; Auto-completion for a variety of languages
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-dabbrev-downcase 0)
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 1)
  (setq company-tooltip-align-annotations t))

;; git Project Support
(use-package projectile
  :ensure t
  :config
  (projectile-mode))

;; Better Searching w/ Ivy
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("C-M-j" . 'counsel-switch-buffer)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  ;; Uncomment the following line to have sorting remembered across sessions!
  ;(prescient-persist-mode 1)
  (ivy-prescient-mode 1))

;; Better Help Buffers with more useful info 
(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; git client in emacs
(use-package magit
  :ensure t)

;; Support for shortcut finding
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(setq mac-command-modifier 'meta) ; set cmd to meta

;; DOOM Emacs themes
(use-package doom-themes
  :ensure t
  :preface (defvar region-fg nil) ; this prevents a weird bug with doom themes
  :init (load-theme 'doom-one t))

;; Dashboard for Emacs startup
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(setq dashboard-items '((recents  . 10)
                        (bookmarks . 5)
                        (projects . 10)
                        (agenda . 15)
                        (registers . 5)))

;; Better for visually tracking code
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Org Roam
;; (use-package org-roam
;;   :ensure t
;;   :custom
;;   (org-roam-directory "/Users/fredericowieser/git/MyPKMS-FLJDOW/org-notes")
;;   :bind (("C-c n l" . org-roam-buffer-toggle)
;;          ("C-c n f" . org-roam-node-find)
;;          ("C-c n i" . org-roam-node-insert))
;;   :config
;;   (org-roam-setup))

;; Ranger, file/folder searching
;; (use-package ranger
;;   (setq ranger-show-hidden t)
;;   (setq ranger-preview-file t)
;;   (setq ranger-excluded-extensions '("mkv" "iso" "mp4"))
;;   (setq ranger-max-preview-size 10)
;;   (setq ranger-dont-show-binary t)

;; Go-to line preview
;; (global-set-key [remap goto-line] 'goto-line-preview)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  ;; Whether display the time. It respects `display-time-mode'.
  (setq doom-modeline-time t))


;;
;; Bindings
;;

(global-set-key (kbd "C-\\") 'comment-or-uncomment-region) ; easy binding for commenting
(global-set-key (kbd "C-h D") 'devdocs-lookup) ;; Devdocs
;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-c C-c") 'clipboard-kill-region)
(global-set-key (kbd "C-c C-v") 'clipboard-yank)
