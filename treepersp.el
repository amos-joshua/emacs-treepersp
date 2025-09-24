;; treepersp.el --- Treemacs + persp-mode projects -*- lexical-binding: t; -*-

;; Author: Amos Joshua <amos@swiftllama.net>
;; Version: 0.1
;; Keywords: convenience, treemacs, projectile
;; URL: https://github.com/your-username/my-emacs-config

;;; Commentary:

;; treemacs + perspmode

;;; Code:

(require 'treemacs-core)
(require 'persp-mode)


(defun treepersp-test-install ()
  "Display a message to confirm a successful treepersp installation."
  (interactive)
  (message "Treepersp package loaded successfully!"))

(provide 'treepersp)

;;; treepersp.el ends here
