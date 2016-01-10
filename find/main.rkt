#lang racket/base

(require rackme)

(define window (get-current-window))
(define selection (address-of-dot window))

(println (format "start of selection: ~a" (range-start selection)))
(println (format "end of selection: ~a" (range-end selection)))
