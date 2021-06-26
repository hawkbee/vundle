;;; ~/.config/doom/config.el -*- lexical-binding: t; -*-
(setq-default
 ;; doom-font (font-spec :family "WenQuanYi Zen Hei Mono" :size 20)
 ;; doom-font (font-spec :family "WenQuanYi Micro Hei Mono" :size 22)
 ;; doom-serif-font (font-spec :family "WenQuanYi Micro Hei Mono" :size 20)
 ;; doom-font (font-spec :family "Consolas" :size 24)
 doom-font (font-spec :family "Consolas Ligaturized" :size 24)
 ;; doom-font (font-spec :family "Droid Sans Mono" :size 22)
 ;; doom-font (font-spec :family "Fira Code" :size 22)
 ;; doom-font (font-spec :family "Anonymous Pro" :size 22)
 ;; doom-font (font-spec :family "Fantasque Sans Mono" :size 22)
 ;; doom-font (font-spec :family "AR PL UKai CN" :size 24)
 ;; doom-font (font-spec :family "Noto Sans Mono Light" :size 18)
 +format-on-save-enabled-modes '(not c-mode emacs-lisp-mode sql-mode markdown-mode gfm-mode) ; elisp's mechanisms are good enough
 +pretty-code-enabled-modes '(emacs-lisp-mode org-mode)
 package-archives
 (let ((proto (if gnutls-verify-error "https" "http")))
   `(("gnu"   . ,(concat proto "://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/"))
     ("melpa" . ,(concat proto "://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"))
     ("org"   . ,(concat proto "://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))))


(after! format-all
  (set-formatter! 'lua-fmt
  '("luafmt"
    "-l" "99"
    "-i" "2"
    ;; ("-i" "%d" tab-width)
    "--stdin")))

(after! plantuml-mode
  (setq plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar"
        org-plantuml-jar-path plantuml-jar-path))

(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
(add-to-list 'auto-mode-alist '("\\.wpy\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tmpl\\'" . web-mode))
(delete-selection-mode)
;; (setq select-enable-clipboard t)
(setq select-enable-primary t)
(setq format-all-debug t)
(setq +lookup-open-url-fn 'eww)

;; (set-company-backend! '(c-mode c++-mode) '(company-gtags company-dabbrev-code company-irony))

(map!
 :n "C-h" #'evil-window-left
 :n "C-j" #'evil-window-down
 :n "C-k" #'evil-window-up
 :n "C-l" #'evil-window-right
 (:after treemacs-evil
   (:map evil-treemacs-state-map
     "C-h" #'evil-window-left
     "C-l" #'evil-window-right))
 ;;(:leader
  ;; (:prefix "f"
   ;;  :description "" :n "t" #'nil))
 )

(use-package! evil-matchit
  :config (global-evil-matchit-mode 1))
