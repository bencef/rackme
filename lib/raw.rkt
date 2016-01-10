#lang racket/base

(require (for-syntax
           syntax/parse
           racket/base))

(provide with-open-acme-files
         acme-write
         acme-read
         acme-read-num)

(define-syntax (with-open-acme-files stx)
  (define-syntax-class open-mode
    (pattern (~or 'r 'w 'wa 'rw 'rwa)))
  (define-syntax-class file-binding
    (pattern (name:id
              path:expr
              mode:open-mode)))
  (syntax-parse stx
    [(_ (bindings:file-binding ...+) body:expr ...+)
     ;; use open-input-output-file
     ;; use case for mode
     (datum->syntax stx '(range 1 2))]))

(define (acme-read handle length)
  #f)

(define (acme-write handle data)
  #f)

(define (acme-read-num handle)
  (define num-field-len 11)
  (string->number (read handle num-field-len)))
