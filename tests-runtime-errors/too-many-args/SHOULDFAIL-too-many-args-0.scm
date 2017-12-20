; this test has a lambda applied with too many args
; should result in a halt with a "too many args" error message


(define z '10)
(define b '11)
(define x '12)

(letrec ([k (letrec ([f (lambda (n j k) (cons (cons n j) k))])
              (f
               ((lambda (m) m) z)
               (letrec* ([arg ((lambda (x) (+ x x)) x)])
                          (+ arg arg))
               b
               (+ b b)))]) k)
                                         

; (lambda (n j k) here is provided with 4 instead of 3 args
