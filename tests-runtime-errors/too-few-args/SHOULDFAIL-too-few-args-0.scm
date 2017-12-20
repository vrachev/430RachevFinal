; this test has a lambda applied with too few args
; should result in a "too few args" error message


(define z '10)
(define b '11)
(define x '12)

(letrec ([k (letrec ([f (lambda (n j k) (cons (cons n j) k))])
              (f
               ((lambda (m) m) z)
               (letrec* ([arg ((lambda (x) (+ x x)) x)])
                          (+ arg arg))))]) k)
                                         

; (lambda (n j k) here is provided with 2 instead of 3 args
