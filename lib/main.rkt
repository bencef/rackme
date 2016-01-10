#lang racket/base

(require "raw.rkt"
         "range.rkt")

(provide get-current-window
         address-of-dot
         (struct-out range))

(define (get-current-window)
  (define winid (getenv "winid"))
  (if winid
    winid
    (raise exn:fail
           "Couldn't read envvar 'winid'")))

(define (address-of-dot w)
  (with-open-acme-files ([addr (format "~a/addr" w) 'r]
                         [ctl (format "~a/ctl" w) 'wa])
    (acme-write ctl "addr=dot")
    (let ([start (acme-read-num addr)
           end   (acme-read-num addr)]
      (make-range start end)))))
