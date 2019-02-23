;; -*- no-byte-compile: t; -*-
;;; lang/cc/packages.el

(cond
 ((featurep! :completion ivy)
  (package! counsel-gtags))
 ((featurep! :completion helm)
  (package! helm-gtags)))
