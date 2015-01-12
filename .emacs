;; .emacs

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;(require 'sublimity)
;(require 'sublimity-scroll)
;(require 'sublimity-map)
;(require 'sublimity-attractive)

;(setq sublimity-map-fraction 0.2)
;(sublimity-map-set-delay 0)

;(setq sublimity-scroll-weight 5
;     sublimity-scroll-drift-length 0)

(when (not package-archive-contents)
  (package-refresh-contents))
;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

(load-theme 'solarized-dark t)

(set-face-attribute 'default nil :font "Inconsolata" )
(set-frame-font "Inconsolata" nil t)


;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
;(setq require-final-newline 'query)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config)
;
(ac-config-default)
(add-to-list 'ac-sources 'ac-source-c-headers)

(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)
        (next-line)))


(electric-pair-mode 1)

(define-key global-map (kbd "RET") 'newline-and-indent)

(setq-default c-basic-offset 4)

;; (setq linum-disabled-modes-list ‘(eshell-mode wl-summary-mode compilation-mode)) (defun linum-on () (unless (or (minibufferp) (member major-mode linum-disabled-modes-list)) (linum-mode 1)))

(require 'linum)

(defcustom linum-disabled-modes-list '(eshell-mode wl-summary-mode compilation-mode org-mode dired-mode doc-view-mode image-mode)
  "* List of modes disabled when global linum mode is on"
  :type '(repeat (sexp :tag "Major mode"))
  :tag " Major modes where linum is disabled: "
  :group 'linum
  )
(defcustom linum-disable-starred-buffers 't
  "* Disable buffers that have stars in them like *Gnu Emacs*"
  :type 'boolean
  :group 'linum)

(defun linum-on ()
  "* When linum is running globally, disable line number in modes defined in `linum-disabled-modes-list'. Changed by linum-off. Also turns off numbering in starred modes like *scratch*"

  (unless (or (minibufferp)
              (member major-mode linum-disabled-modes-list)
              (string-match "*" (buffer-name))
              (> (buffer-size) 3000000)) ;; disable linum on buffer greater than 3MB, otherwise it's unbearably slow
    (linum-mode 1)))

(defun my-bell-function ()
  (unless (memq this-command
        '(isearch-abort abort-recursive-edit exit-minibuffer
              keyboard-quit mwheel-scroll down up next-line previous-line
              backward-char forward-char))
    ()))
(setq ring-bell-function 'my-bell-function)


(provide 'linum-off)

;; (setq linum-format “%d “)

(global-linum-mode 1)

(scroll-bar-mode -1)

(tool-bar-mode -1)

(require 'tramp)
(setq tramp-default-method "scp")

(modify-all-frames-parameters (list (cons 'cursor-type 'bar)))

(require 'ergoemacs-mode)

(setq ergoemacs-theme nil) ;; Uses Standard Ergoemacs keyboard theme
(setq ergoemacs-keyboard-layout "us") ;; Assumes QWERTY keyboard layout
(ergoemacs-mode 1)


(global-set-key (kbd "C-;") 'comment-or-uncomment-region-or-line) ; ctrl+a
