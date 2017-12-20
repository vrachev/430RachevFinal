; this test has a division by zero operation
; should result in a div by zero error message being raised

(define (divide pair)
  (let ([fst (car (pair))] [scnd (cdr (pair))])
    (/ fst scnd)))


(define func
  (let ([scnd 0])
    (let ([fst 900])
      (divide (lambda () (cons fst scnd))))))

func