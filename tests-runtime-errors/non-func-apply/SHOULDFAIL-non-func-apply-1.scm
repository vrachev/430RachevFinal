(let ([func (letrec ([b '(25 11)])
  (apply (lambda (v x)
         (- v x)) b))])
  (apply func '(10 '15)))