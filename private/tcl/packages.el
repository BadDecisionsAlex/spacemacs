;;; packages.el --- tcl layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author:  <camus@petr>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `tcl-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `tcl/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `tcl/pre-init-PACKAGE' and/or
;;   `tcl/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst tcl-packages
  '(tcl)
  "The list of Lisp packages required by the tcl layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun tcl/init-tcl ()
  "This is primarily based on Clojure and JavaScript's `package.el' files.
   `spacemacs/set-leader-keys-for-major-mode' will use each binding's value
   as it's ``hint'', so if you define a lambda, use
   `spacemacs/declare-prefix-for-mode' to redefine the ``hint'' manually.
   when you do, don't forget to prepend `m' to each binding, because
   `spacemacs/set-leader-keys-for-major-mode' does this implicitly.
   A lambda function stolen from `clojure/packages.el' makes things a bit more
   straightforward"
  (use-package tcl
    :defer nil

    :init
    (progn
      (spacemacs/register-repl 'tcl 'inferior-tcl "tclsh"))

    :config
    (progn
      (spacemacs/set-leader-keys-for-major-mode 'tcl-mode
        "'"  'inferior-tcl
        "ss" 'inferior-tcl
        ;;"si" (spacemacs|with-inferior-tcl switch-to-tcl) ;; FIXME
        "si" 'switch-to-tcl
        "sb" (lambda ()
               (interactive)
               (tcl-load-file (buffer-file-name)))
        "sB" (lambda ()
               (interactive)
               (tcl-load-file (buffer-file-name) t))
        )

      (mapc
       (lambda (x)
         (spacemacs/declare-prefix-for-mode 'tcl-mode
           (concat "m" (car x)) (cdr x)))

       '(("'" . "tclsh")
         ("ss" . "tclsh")
         ("sb" .  "tclsh-send-buffer")
         ("sB" . "tclsh-send-buffer-and-focus")))
      )
;; End Config --------------------------------------------------------------- ;;
    ))

;;; packages.el ends here
