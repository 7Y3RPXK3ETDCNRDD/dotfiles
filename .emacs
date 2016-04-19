; PACKAGE MANAGER
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

; KEY BINDINGS
(require 'bind-key)

; <LEADER> KEU
(add-to-list 'load-path "~/.emacs.d/evil-leader/")
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")

; EVIL MODE
(require 'evil)
(evil-mode 1)

; MODE LINE
(add-to-list 'load-path "~/.emacs.d/custom")
(load "custom_mode-line")

; NO
(defalias 'yes-or-no-p 'y-or-n-p)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq make-backup-files nil)
(setq auto-save-default nil)

; CONVINIENT WAY TO CHANGE FACES
(load "facemenu")
(require 'facemenu+)

; THEMES
(add-to-list 'custom-theme-load-path "~/.emacs.d/monokai/")
(load-theme 'gotham t)

; LINE NUMBERS
;; HIGHLIGHT CURRENT LINE NUMBER
(load "linum_highlight")
(global-linum-mode 1)

; SMARTPARENTS
(add-to-list 'load-path "~/.emacs.d/smartparents/")
(require 'smartparens-config)
(smartparens-global-mode 1)

; BUFFER STUFF
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

; STARTUP WITH SCRATCH
(setq inhibit-startup-message t
inhibit-startup-echo-area-message t)

; SMOOTH SCROLLING
(add-to-list 'load-path "~/.emacs.d/scrolling/")
(require 'smooth-scrolling)
(setq scroll-margin 5
scroll-conservatively 9999
scroll-step 1)

; HELM
(add-to-list 'load-path "~/.emacs.d/helm/")
(add-to-list 'load-path "~/.emacs.d/assync/")
(require 'helm-config)
(bind-key "M-x" 'helm-M-x)

; EASY MOTION
(require 'avy)
(evil-leader/set-key ", k" 'avy-goto-line)
(evil-leader/set-key ", j" 'avy-goto-line)
(evil-leader/set-key ", w" 'avy-goto-word-1)
(evil-leader/set-key ", f" 'avy-goto-char-2)

; NERD COMMENTER
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-key
  "ci" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
  "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
  "cc" 'evilnc-copy-and-comment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "cv" 'evilnc-toggle-invert-comment-line-by-line
  "\\" 'evilnc-comment-operator ; if you prefer backslash key
)

; CONVINIENT STUFF
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

(define-key evil-normal-state-map (kbd "C-k") (lambda ()
                    (interactive)
                    (evil-scroll-up nil)))
(define-key evil-normal-state-map (kbd "C-j") (lambda ()
                        (interactive)
                        (evil-scroll-down nil)))
; ESC QUITS EVERYTHING
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

;; CURRENT LINE HIGHLIGHT
(global-hl-line-mode)

;; PARENTHESIS HIGHLIGHT
(setq show-paren-delay 0)
(show-paren-mode 1)

;; SYNTAX HIGHLIGHT
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;; DON'T MOVE CURSOR AFTER C-c
(setq evil-move-cursor-back nil)

;; YEAH
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)
(desktop-save-mode 1)

;; CURSOR
(setq evil-normal-state-cursor '(box "purple"))
(setq evil-insert-mode '(underline "purple"))
; }}}

;;BUFFER
(global-set-key (kbd "C-x C-b") 'ibuffer)

; C++ ENVIRONMENT
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-backends (delete 'company-semantic company-backends))
(setq company-idle-delay 0)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))
(projectile-global-mode)
(setq c-default-style "linux"
          c-basic-offset 4)
(defun my-indent-setup ()
    (c-set-offset 'arglist-intro '+))
(add-hook 'java-mode-hook 'my-indent-setup)
(add-hook 'c-mode-common-hook   'hs-minor-mode)

; C-c as general purpose escape key sequence.
(defun my-esc (prompt)
    "Functionality for escaping generally.  Includes exiting Evil insert state and C-g binding. "
    (cond
    ;; Key Lookup will use it.
    ((or (evil-insert-state-p) (evil-replace-state-p) (evil-visual-state-p)) [escape])
    ;; This is the best way I could infer for now to have C-c work during evil-read-key.
    ;; Note: As long as I return [escape] in normal-state, I don't need this.
    ;;((eq overriding-terminal-local-map evil-read-key-map) (keyboard-quit) (kbd ""))
    ))
(define-key key-translation-map (kbd "C-c") 'my-esc)
;; Works around the fact that Evil uses read-event directly when in operator state, which
;; doesn't use the key-translation-map.
(define-key evil-operator-state-map (kbd "C-c") 'keyboard-quit)
;; Not sure what behavior this changes, but might as well set it, seeing the Elisp manual's
;; documentation of it.
(set-quit-char "C-c")

; CUSTOMIZE GENERATED STUFF
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#0A0A0A" :foreground "#FFFFFF" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "xos4" :family "Terminus"))))
 '(cursor ((t (:background "#F8F8F2" :inverse-video t))))
 '(fringe ((t (:background "#0A0A0A" :foreground "#0A0A0A"))))
 '(isearch ((t (:background "#E6DB74" :foreground "#272822" :weight normal))))
 '(linum ((t (:background "#0A0A0A" :foreground "#75715E"))))
 '(linum-current-line ((t (:inherit linum :foreground "#FD971F" :weight bold))))
 '(mode-line ((t (:background "#3E3D31" :foreground "#F8F8F2" :box (:line-width 3 :color "#3E3D31" :style unspecified)))))
 '(show-paren-match ((t (:background "black" :foreground "#FD971F" :inverse-video t :weight normal))))
 '(sp-show-pair-match-face ((t (:background "#272822" :foreground "#FD971F" :inverse-video t :weight normal)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d9046dcd38624dbe0eb84605e77d165e24fdfca3a40c3b13f504728bab0bf99d" default)))
 '(ido-enable-flex-matching t))

