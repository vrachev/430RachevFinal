; this test has a lambda applied with the right amount of args
; should evaluate normally


(define z '10)
(define b '11)
(define x '12)

(letrec ([k (letrec ([f (lambda (n j k) (cons (cons n j) k))])
              (f
               ((lambda (m) m) z)
               (letrec* ([arg ((lambda (x) (+ x x)) x)])
                          (+ arg arg))
               b))]) k)
                                         

; (lambda (n j k) here is provided with the appropriate (3) number of args