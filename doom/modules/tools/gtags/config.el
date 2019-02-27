;;; lang/cc/config.el -*- lexical-binding: t; -*-

(def-package! counsel-gtags
  :when (featurep! :completion ivy)
  :init
  (add-hook 'c-mode-common-hook 'counsel-gtags-mode)
  :config
  (setq counsel-gtags-auto-update t)
  (set-lookup-handlers! '(c-mode c++-mode)
    :definition #'counsel-gtags-dwim
    ;; :definition #'counsel-gtags-find-definition
    :documentation #'+default/man-or-woman
    :references #'counsel-gtags-find-reference))

(def-package! helm-gtags
  :when (featurep! :completion helm)
  :init
  (add-hook 'c-mode-common-hook 'helm-gtags-mode)
  :config
  (set-lookup-handlers! '(c-mode c++-mode)
    :definition #'helm-gtags-dwim
    :documentation #'+default/man-or-woman
    :references #'counsel-gtags-find-reference))
