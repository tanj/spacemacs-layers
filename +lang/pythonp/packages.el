;; -*- lexical-binding: t -*-
;;
;; Author: Rainer Gemulla <rgemulla@gmx.de>
;;
;; This file is not part of GNU Emacs.
;;
;;; Code:

(defconst pythonp-packages
  '(elpy))

(defun pythonp/init-elpy ()
  (spacemacs|use-package-add-hook python
    :post-config
    ;; load the elpy-shell definitions
    (require 'elpy-shell)
    (add-hook 'inferior-python-mode-hook 'elpy-shell--enable-output-filter)

    ;; faster send
    (advice-add #'python-shell-buffer-substring :around #'pythonp//no-python-mode-hook-advice)

    ;; add the bindings
    (spacemacs/declare-prefix-for-mode 'python-mode "me" "send to REPL")
    (spacemacs/declare-prefix-for-mode 'python-mode "ms" "send to REPL and step")
    (spacemacs/set-leader-keys-for-major-mode 'python-mode
      "ee" 'elpy-shell-send-statement
      "eE" 'elpy-shell-send-statement-and-go
      "es" 'elpy-shell-send-top-statement
      "eS" 'elpy-shell-send-top-statement-and-go
      "ef" 'elpy-shell-send-defun
      "eF" 'elpy-shell-send-defun-and-go
      "ec" 'elpy-shell-send-defclass
      "eC" 'elpy-shell-send-defclass-and-go
      "eg" 'elpy-shell-send-group
      "eG" 'elpy-shell-send-group-and-go
      "ew" 'elpy-shell-send-codecell
      "eW" 'elpy-shell-send-codecell-and-go
      "er" 'elpy-shell-send-region-or-buffer
      "eR" 'elpy-shell-send-region-or-buffer-and-go
      "eb" 'elpy-shell-send-buffer
      "eB" 'elpy-shell-send-buffer-and-go
      "se" 'elpy-shell-send-statement-and-step
      "sE" 'elpy-shell-send-statement-and-step-and-go
      "ss" 'elpy-shell-send-top-statement-and-step
      "sS" 'elpy-shell-send-top-statement-and-step-and-go
      "sf" 'elpy-shell-send-defun-and-step
      "sF" 'elpy-shell-send-defun-and-step-and-go
      "sc" 'elpy-shell-send-defclass-and-step
      "sC" 'elpy-shell-send-defclass-and-step-and-go
      "sg" 'elpy-shell-send-group-and-step
      "sG" 'elpy-shell-send-group-and-step-and-go
      "sw" 'elpy-shell-send-codecell-and-step
      "sW" 'elpy-shell-send-codecell-and-step-and-go
      "sr" 'elpy-shell-send-region-or-buffer-and-step
      "sR" 'elpy-shell-send-region-or-buffer-and-step-and-go
      "sb" 'elpy-shell-send-buffer-and-step
      "sB" 'elpy-shell-send-buffer-and-step-and-go
      "si" 'elpy-shell-switch-to-shell
      "sI" 'elpy-shell-switch-to-shell-in-current-window
      "'" 'elpy-shell-switch-to-shell)

    ;; toggles
    (spacemacs/declare-prefix-for-mode 'python-mode "mt" "toggles")
    (spacemacs|add-toggle pythonp/shell-display-buffer-after-send
      :documentation "Toggles whether to show the python shell after sending something to it"
      :status elpy-shell-display-buffer-after-send
      :on (setq elpy-shell-display-buffer-after-send t)
      :off (setq elpy-shell-display-buffer-after-send nil)
      :evil-leader-for-mode (python-mode . "td"))

    (spacemacs|add-toggle pythonp/shell-echo-input
      :documentation "Toggles whether to echo input sent to the Python shell in the shell buffer"
      :status elpy-shell-echo-input
      :on (setq elpy-shell-echo-input t)
      :off (setq elpy-shell-echo-input nil)
      :evil-leader-for-mode (python-mode . "ti"))

    (spacemacs|add-toggle pythonp/shell-echo-output
      :documentation "Toggles whether to echo the Python shell output in the echo area"
      :status elpy-shell-echo-output
      :on (setq elpy-shell-echo-output 'when-shell-not-visible)
      :off (setq elpy-shell-echo-output nil)
      :evil-leader-for-mode (python-mode . "to"))

    ;; inferior-python-mode key bindings
    (spacemacs/declare-prefix-for-mode 'inferior-python-mode "mg" "goto")
    (spacemacs/set-leader-keys-for-major-mode 'inferior-python-mode
      "si" 'elpy-shell-switch-to-buffer
      "sI" 'elpy-shell-switch-to-buffer-in-current-window)
    (when (configuration-layer/layer-used-p 'ivy)
      (define-key inferior-python-mode-map (kbd "C-r") 'counsel-shell-history))
    (when (configuration-layer/layer-used-p 'helm)
      (define-key inferior-python-mode-map (kbd "C-r") 'spacemacs/helm-shell-history))

    ;; jump to class/function definition with ivy
    (when (configuration-layer/layer-used-p 'ivy)
      (spacemacs/set-leader-keys-for-major-mode 'python-mode
        "gc" #'pythonp/counsel-projectile-python-class
        "gf" #'pythonp/counsel-projectile-python-function))
    ))
