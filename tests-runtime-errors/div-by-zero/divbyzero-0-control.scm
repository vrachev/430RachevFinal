; this test is the same as divbyzero-0 except it has division with a non-zero value
; should NOT result in a error message, should evaluate to a concrete value

(define x '1)

(define z '10)
(define b '11)

(letrec ([k (letrec ([f (lambda (n) (if (eqv? z n)
                                       (begin
                                         (set! z '0)
                                         (set! x '100)
                                         '110
                                         )
                                       (begin
                                         (set! z '2)
                                         '212)))])
              (f b))]) (/ k ((lambda (j) j) z))) 
                                         


