;; -*- lexical-binding: t -*-
;;
;; Author: John te Bokkel <tanj.tanj@gmail.com>
;;
;; This file is not part of GNU Emacs.
;;
;;; Code:

(defconst jtfold-packages
  '(vimish-fold))

(defun jtfold/post-init-vimish-fold ()
  (spacemacs/set-leader-keys "off" 'vimish-fold)
  (spacemacs/set-leader-keys "ofu" 'vimish-fold-unfold)
  (spacemacs/set-leader-keys "ofd" 'vimish-fold-delete)
  )
