; this test does not have a division by zero operation
; should not result in a div by zero error message being raised
; should return concrete value (90)


(define (divide pair)
  (let ([fst (car (pair))] [scnd (cdr (pair))])
    (/ fst scnd)))


(define func
  (let ([scnd 10])
    (let ([fst 900])
      (divide (lambda () (cons fst scnd))))))

func