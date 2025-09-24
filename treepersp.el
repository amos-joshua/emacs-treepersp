;; treepersp.el --- Treemacs + persp-mode projects -*- lexical-binding: t; -*-

;; Author: Amos Joshua <amos@swiftllama.net>
;; Version: 0.1
;; Keywords: convenience, treemacs, projectile
;; URL: https://github.com/your-username/my-emacs-config

;;; Commentary:

;; treemacs + perspmode

;;; Code:

;(require 'treemacs-core)
;(require 'persp-mode)

(defun treepersp-switch-num (perspnum)
  (interactive)
  (let ((proj (nth perspnum (persp-names))))
    (message "hello")
    (message proj)
       )
  )

(defun treepersp-persp-with-prefix (prefix)
  (let ((matchingWorkspace nil))
     (dolist (workspace (persp-names) matchingWorkspace)
       (if (string-match prefix workspace)
           (setq matchingWorkspace workspace)
         )
       )
     matchingWorkspace)
  )

(defun treepersp-switch-prefix (prefix)
  (interactive)
   (let ((workspace (treepersp-persp-with-prefix prefix)))
     (when workspace
       (message workspace)
       (persp-switch workspace)
       )
     (unless workspace
       (let ((workspace (treepersp-choose-workspace)))
         (when workspace
           (persp-switch (format "%s-%s" prefix workspace))
           )
         )
     (message "no workspace with prefix '%s'" prefix)
     )
   )
   )

(defun treepersp-clear-prefix (prefix)
  (interactive)
   (let ((workspace (treepersp-persp-with-prefix prefix)))
     (when workspace
       (persp-remove-by-name workspace)
       (message "Cleared workspace #%s: %s" prefix workspace)
       )
     )

  )


(defun treepersp-treemacs-matching-name-as-suffix (prefixed-workspace)
  (let ((matchingWorkspace nil))
    (dolist (workspace (treemacs-workspaces) matchingWorkspace)
      (let ((workspace-name (treemacs-workspace->name workspace)))
        (message "matching %s against %s" prefixed-workspace workspace-name)
      (if (string-match (format "%s$" workspace-name) prefixed-workspace)
          (progn
            (setq matchingWorkspace workspace)
            (message "%s matches %s" (treemacs-workspace->name workspace) prefixed-workspace)
          )
      )

       )
     matchingWorkspace)
    )
  )

(defun treepersp-switch-to-treemacs-workspace (workspace-name)
    "Switch to treemacs workspace by name."
    (let ((workspaces (treemacs-workspaces))
          (found nil))
      ;; Check if workspace exists
      (dolist (ws workspaces)
        (when (string= (treemacs-workspace->name ws) workspace-name)
          (setq found t)))
      (if found
          (treemacs-switch-workspace workspace-name)
        (message "Workspace '%s' not found" workspace-name))))



(defun treepersp-choose-workspace ()
    (let* ((choices (treepersp-treemacs-workspace-names))
         (selected (completing-read "Workspace: " choices nil t)))
    (if (string-empty-p selected)
        (message "Cancelled")
        'nil
      selected))
  )

(defun treepersp-test-install ()
  "Display a message to confirm a successful treepersp installation."
  (interactive)
  (message "Treepersp package loaded successfully!"))

(provide 'treepersp)

;;; treepersp.el ends here

(treepersp-treemacs-workspace-names)

(defun treepersp-treemacs-workspace-names ()
(mapcar (lambda (ws) (treemacs-workspace->name ws))
        (treemacs-workspaces))
)

(treepersp-choose-workspace)

