#lang racket
(require racket/draw)
(require pict)
(require pict/tree-layout)
(require racket/random)


(provide λ-pict)


(define λ-pict
  (λ (exp #:node-size (node-size 15))
    (naive-layered
     (let ([new-color (make-color-generator)])
       (let T ([exp exp]
               [env (hash)])
         (match exp
           [`,x
            #:when (symbol? x)
            (tree-layout
             #:pict (make-reference-node node-size
                      (hash-ref env x)))]
           [`(quote ,lit)
            (tree-layout
             #:pict (make-datum-node node-size
                      (new-color)))]
           [`(λ (,x) ,b)
            #:when (symbol? x)
            (let ([color (new-color)])
              (tree-layout
               #:pict (make-abstraction-node
                       node-size color)
               (T b (hash-set env x color))))]
           [`(,rator ,rand)
            (tree-layout
             #:pict (make-app-node node-size)
             (T rator env)
             (T rand env))]))))))


(define (make-color-generator)
  (let ([clrs (random-sample
               (let ([4b (stream->list (in-range 16))])
                 (cartesian-product 4b 4b 4b))
               (* 16 16 16))])
    (λ ()
      (let ([c (car clrs)])
        (set! clrs (cdr clrs))
        (match c
          [`(,i ,j ,k)
           (make-object color%
             (* i 16)
             (* j 16)
             (* k 16))])))))


(define new-color
  (λ () (make-object color%
          (random 256)
          (random 256)
          (random 256))))


(define (make-app-node node-size)
  (text "@" null node-size))


(define (make-reference-node node-size color)
  (disk node-size
        #:color color
        #:border-color color))


(define (make-abstraction-node node-size color)
  (disk node-size
        #:color "white"
        #:border-color color
        #:border-width (/ node-size 5)))


(define (make-datum-node node-size color)
  (filled-rectangle node-size node-size #:color color
                    #:border-color color))