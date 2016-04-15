#lang racket/base

(require (for-syntax racket/base
                     racket/syntax
                     syntax/parse)
         racket/string)

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
              mode:open-mode)
             #:attr form
             (let* ([m (syntax->datum #'mode)]
                    [wmode (case m
                             [('wa 'rwa) 'append]
                             [else 'truncate])])
               (case m
                 [('r) #'(cons (open-input-file path
                                                #:mode 'binary) #f)]
                 [('w 'wa) #`(cons #f (open-output-file path
                                                        #:mode 'binary
                                                        #:exists '#,wmode))]
                 [('rw 'rwa) #`(let-values ([(in out) (open-input-output-file path
                                                                              #:mode 'binary
                                                                              #:exists '#,wmode)])
                                 (cons in out))]))))
  (syntax-parse stx
    [(_ (binding:file-binding ...+) body:expr ...+)
     #'(parameterize ([current-custodian (make-custodian)])
         (let ([binding.name binding.form] ...)
           body ...))]))

(define (acme-read handle length)
  (read-string length (car handle)))

(define (acme-write handle data)
  (define port (cdr handle))
  (write-string data port)
  (flush-output port))

(define (acme-read-num handle)
  (define num-field-len 12)
  (define str (acme-read handle num-field-len))
  (define num (string-trim str))
  (string->number num))
