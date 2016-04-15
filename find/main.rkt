#lang racket/base

(require rackme)

(define (usage)
  ;; TODO write meaningful help and exit
  (raise exn:fail
         "Expected one argument"))

(define argv (current-command-line-arguments))

;; validate command line arguments
(unless (= 1 (vector-length argv))
  (usage))

(define query-string (vector-ref argv 0))
(define ns (get-ns))
(define window (get-current-window))
(define first-find
  (with-open-acme-files ([addr (format "~a/~a/addr" ns window) 'rwa])
    (acme-write addr (format "/~a/" query-string))
    ;; this is already a recurring pattern.
    ;; TODO refactor
    (let* ([start (acme-read-num addr)]
           [end   (acme-read-num addr)])
      (range start end))))

(displayln (format "start of first-find: ~a" (range-start first-find)))
(displayln (format "end of first-find: ~a" (range-end first-find)))
