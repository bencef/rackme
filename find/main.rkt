#lang racket/base

(require rackme)

(define ns (get-ns))
(define window (get-current-window))
(define selection (address-of-dot (format "~a/~a" ns window)))

(displayln (format "start of selection: ~a" (range-start selection)))
(displayln (format "end of selection: ~a" (range-end selection)))
