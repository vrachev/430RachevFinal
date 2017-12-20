(define m 'world)

(letrec* ([z 'hello] [a (lambda (arg) (cons z arg))])
         (let ([func (lambda (x)
                       (a x))])
           (func m m)))


