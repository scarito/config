; ctags config
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "ctags -f %s/TAGS -e -R %s" (directory-file-name dir-name) (directory-file-name dir-name)))
)

;package
(require 'package)
(package-initialize)

(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(add-to-list 'load-path "~/.emacs.d")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'sanityinc-solarized-dark)
(set-default-font "Ubuntu Mono-12")

; don't use tabs for indenting
(setq-default indent-tabs-mode nil)

; highlight symbol command
(require 'highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)

; rainbow delimiters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

; display line and column numbers
(setq column-number-mode t)
(global-linum-mode t)

; fill column indicator
(require 'fill-column-indicator)
(setq fci-mode t)
(setq fci-rule-width 1)
(setq fci-rule-color "darkgray")
(setq fci-rule-column 80)
(add-hook 'c-mode-hook 'fci-mode)
(add-hook 'c++-mode-hook 'fci-mode)
(add-hook 'python-mode-hook 'fci-mode)
(setq-default fill-column 80)

; set window width
(defun set-window-width (n)
  "Set the selected window's width."
  (adjust-window-trailing-edge (selected-window) (- n (window-width)) t))

(defun set-80-columns ()
  "Set the selected window to 80 columns."
  (interactive)
  (set-window-width 84))  ; hack to ensure enough space with line numbers.

(global-set-key "\C-x~" 'set-80-columns)

; trailing whitespace
; includes fci mode compatibility hack from https://github.com/alpaker/Fill-Column-Indicator/issues/10
(require 'whitespace)
(setq-default whitespace-style '(face trailing))
(setq-default whitepace-line-column 80)
(global-whitespace-mode 1)
(setq-default show-trailing-whitespace t)

; disable background
(global-unset-key (kbd "C-z"))

; buffer naming
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

; focus follows mouse
(setq mouse-autoselect-window t)

; C mode settings
(c-set-offset 'case-label '+)
(setq-default c-continued-statement-offset 4)
