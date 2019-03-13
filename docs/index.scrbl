#lang scribble/manual
@(require "../visualize-lambda.rkt")


@title{Visualize λ}

Code: @hyperlink[
 "https://github.com/LuKC1024/visualize-lambda"]{
 visualize-λ}

Bound variables are displayed as circles. And variable use
are displayed as disks. @"@" means application.


Omega combinatior

@racket[(λ (x) (x x))]

@(λ-pict '(λ (x) (x x)))


Y combinator

@racket[(λ (f) ((λ (x) (f (x x))) (λ (x) (f (x x)))))]

@(λ-pict '(λ (f) ((λ (x) (f (x x))) (λ (x) (f (x x))))))


Z combinator

@racket[
 (λ (f)
   ((λ (x) (f (λ (v) ((x x) v))))
    (λ (x) (f (λ (v) ((x x) v))))))]

@(λ-pict
  '(λ (f)
     ((λ (x) (f (λ (v) ((x x) v))))
      (λ (x) (f (λ (v) ((x x) v)))))))


Plus in Church encoding

@racket[(λ (m)
            (λ (n)
              (λ (f)
                (λ (x)
                  ((m f) ((n f) x))))))]

@(λ-pict '(λ (m)
            (λ (n)
              (λ (f)
                (λ (x)
                  ((m f) ((n f) x)))))))