;; treepersp.el --- Treemacs + persp-mode projects -*- lexical-binding: t; -*-

;; Author: Amos Joshua <amos@swiftllama.net>
;; Version: 0.1
;; Keywords: convenience, treemacs, projectile
;; URL: https://github.com/your-username/my-emacs-config

;;; Code:

(require 'treemacs-core)
(require 'projectile)

(use-package treemacs
  :ensure t
  :config
  (setq treemacs-width 30)
)

(use-package projectile
  :ensure t
  :config
  (setq projectile-enable-caching t)
)

(use-package treemacs-projectile
  :ensure t
  :after (treemacs projectile))

(provide 'my-treemacs-projectile-config)

;;; my-treemacs-projectile-config.el ends here
