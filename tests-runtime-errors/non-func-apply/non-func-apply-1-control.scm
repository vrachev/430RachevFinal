(let ([val (letrec ([b '(25 11)])
  (apply (lambda (v x)
         (- v x)) b))])
  val)