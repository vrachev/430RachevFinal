; this test has a division by zero operation
; should result in a div by zero error message being raised


(define x '1)

(define z '10)
(define b '10)

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
                                         


