

;; FIXME
(defmacro spacemacs|with-inferior-tcl (cmd)
  "If `inferior-tcl-buffer' is unset, assume that `inferior-tcl' is not running,
   prompt the user to start one before running `cmd'; otherwise just run `cmd'"
  `(lambda ()
     (interactive)
     (if (boundp 'inferior-tcl-buffer) ,cmd
       (when (y-or-n-p "No TCL Repl running. Start One?") ,cmd))))
