;; treepersp.el --- Treemacs + persp-mode projects -*- lexical-binding: t; -*-

;; Author: Amos Joshua <amos@swiftllama.net>
;; Version: 0.1
;; Keywords: convenience, treemacs, projectile
;; URL: https://github.com/your-username/my-emacs-config

;;; Commentary:

;; treemacs + perspmode

;;; Code:

(require 'treemacs)
(require 'perspective)


(defun treepersp-persp-with-prefix (prefix)
  (let ((matchingWorkspace nil))
     (dolist (workspace (persp-names) matchingWorkspace)
       (if (string-match prefix workspace)
           (setq matchingWorkspace workspace)
         )
       )
     matchingWorkspace)
  )

;;;###autoload
(defun treepersp-switch-prefix (prefix)
  (interactive)
   (let ((workspace (treepersp-persp-with-prefix prefix)))
     (when workspace
       (message "[%s]" workspace)
       (persp-switch workspace)
       )
     (unless workspace
       (let* (
              (workspace-name (treepersp-choose-workspace))
              (prefixed-workspace (format "%s-%s" prefix workspace-name))
               (treespace (treepersp-treemacs-matching-name-as-suffix workspace-name))
               (treepath (treepersp-treemacs-first-project-path treespace))
             )
         (when workspace-name
           (persp-switch prefixed-workspace)
           (when treepath
             (find-file treepath)
             (treemacs-do-switch-workspace treespace)
             )

           )
         )
       )
     )
   )

(defun treepersp-persp-names ()
  (interactive)
  (persp-names)
  )

;;;###autoload
(defun treepersp-clear-prefix (prefix)
  "Clear the workspace with the given PREFIX.
If called interactively without an argument, prompt for PREFIX."
  (interactive
   (list (read-string "Enter workspace prefix: ")))
  (let ((workspace (treepersp-persp-with-prefix prefix)))
    (when workspace
      (persp-kill workspace)
      (message "Cleared workspace #%s: %s" prefix workspace))))


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

  
(defun treepersp-go-to-treemacs ()
  "Show the Treemacs window if it's not visible."
  (interactive)
  (if (eq (treemacs-current-visibility) 'visible)
      (treemacs-select-window)
    (treemacs))
  )


(defun treepersp-choose-workspace ()
    (let* ((choices (treepersp-treemacs-workspace-names))
         (selected (completing-read "Workspace: " choices nil t)))
    (if (string-empty-p selected)
        (message "Cancelled")
        'nil
      selected))
  )

(defun treepersp-treemacs-workspace-names ()
  (mapcar (lambda (ws) (treemacs-workspace->name ws))
          (treemacs-workspaces)))

(defun treepersp-treemacs-first-project-path (workspace)
  "Get the path of the first project in WORKSPACE, or nil if none exists."
  (when workspace
    (let ((projects (treemacs-workspace->projects workspace)))
      (when projects
        (treemacs-project->path (car projects))))))

;;;###autoload
(defun treepersp-test-install ()
  "Display a message to confirm a successful treepersp installation."
  (interactive)
  (message "Treepersp package loaded successfully!"))

(provide 'treepersp)

;;; treepersp.el ends here
