;;; ip-address.el --- IP address lookup -*- lexical-binding: t -*-

;; Copyright © 2020 Sean Hutchings <seanhut@yandex.com>

;; Author: Sean Hutchings <seanhut@yandex.com>
;; Maintainer: Sean Hutchings <seanhut@yandex.com>
;; Created: 2020-11-23
;; Keywords: comm
;; Version: 0.1.0
;; Homepage: https://github.com/sean-hut/ip-address
;; License: BSD Zero Clause License (0BSD)

;; Permission to use, copy, modify, and/or distribute this software
;; for any purpose with or without fee is hereby granted.
;;
;; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
;; WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
;; WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
;; AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
;; CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
;; OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
;; NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
;; CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

;;; Change Log: For all notable changes see CHANGELOG.md

;;; Commentary:

;; IP address lookup.
;;
;; Repository: https://github.com/sean-hut/ip-address
;;
;; Documentation: https://sean-hut.github.io/ip-address/

;;; Code:

(defun ip-address ()
  "IP address lookup."
  (interactive)

  (save-excursion

      (let* ((url "https://html.duckduckgo.com/html?q=ip%20address")

	     (webpage-buffer (url-retrieve-synchronously url)))

	(set-buffer webpage-buffer)
	(goto-char (point-min))
	(search-forward "Your IP address is")
	(search-backward "Your")
	(delete-region (point-min) (point))
	(move-end-of-line nil)
	(delete-region (point) (point-max))
	(move-beginning-of-line nil)
	(re-search-forward "<[^>]+>")
	(replace-match "")
	(re-search-forward "<[^>]+>")
	(replace-match "")
	(message "%s" (buffer-string))
	(kill-buffer webpage-buffer))))

(provide 'ip-address)
;;; ip-address.el ends here
