;;; lang/cc/config.el -*- lexical-binding: t; -*-

(use-package! counsel-gtags
  :when (featurep! :completion ivy)
  :defer t
  :init
  (add-hook 'c-mode-common-hook 'counsel-gtags-mode)
  :config
  (counsel-gtags-mode)
  (setq counsel-gtags-ignore-case t)
  ;; (setq counsel-gtags-use-suggested-key-map t)
  (setq counsel-gtags-auto-update t)
  (setq counsel-gtags-custom-dwim (lambda () (call-interactively #'counsel-gtags-dwim)))
  (setq counsel-gtags-custom-refer (lambda () (call-interactively #'counsel-gtags-find-reference)))
  (with-eval-after-load 'evil-maps
    (define-key evil-motion-state-map (kbd "C-]") 'counsel-gtags-dwim)
    (define-key evil-motion-state-map (kbd "C-o") 'counsel-gtags-go-backward))
  (map! :leader
        :after cc-mode
        :map counsel-gtags-mode-map
        (:prefix-map ("c" . "code")
         :desc "gtags reference" "G" #'counsel-gtags-find-reference
         :desc "gtags dwim" "g" #'counsel-gtags-dwim))
  (set-lookup-handlers! '(c-mode c++-mode)
    ;; :definition #'counsel-gtags-dwim
    :definition #'counsel-gtags-dwim
    ;; :definition #'counsel-gtags-find-definition
    ;; :documentation #'+default/man-or-woman
    :references #'counsel-gtags-find-reference))

(use-package! helm-gtags
  :when (featurep! :completion helm)
  :init
  (add-hook 'c-mode-common-hook 'helm-gtags-mode)
  :config
  (map! :localleader
        :after cc-mode
        :map helm-gtags-mode-map
        :n :desc "gtags reference" "cs" #'helm-gtags-find-reference
        :n :desc "gtags dwim" "cg" #'helm-gtags-dwim)
  (set-lookup-handlers! '(c-mode c++-mode)
    ;; :definition #'helm-gtags-dwim
    :definition #'helm-gtags-find-definition
    :documentation #'+default/man-or-woman
    :references #'helm-gtags-find-reference))

(add-hook! 'c-mode-common-hook
  (set-company-backend! 'c-mode
    '(:separate company-irony-c-headers company-irony company-gtags)))
