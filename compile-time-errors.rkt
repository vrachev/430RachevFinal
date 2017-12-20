#lang racket

(require "utils.rkt")

(provide cte)
;(provide compile-time-errors)

#|

pass between top-level and desugar
where 5 run-time errors are captured at compile time

e ::= (letrec* ([x e] ...) e)
    | (letrec ([x e] ...) e)
    | (let* ([x e] ...) e)
    | (let ([x e] ...) e)
    | (let x ([x e] ...) e)
    | (lambda (x ...) e)
    | (lambda x e)
    | (lambda (x ...+ . x) e)
    | (dynamic-wind e e e)
    | (guard (x cond-clause ...) e)
    | (raise e)
    | (delay e)
    | (force e)
    | (and e ...)
    | (or e ...)
    | (cond cond-clause ...)
    | (case e case-clause ...)
    | (if e e e)
    | (when e e)
    | (unless e e)
    | (set! x e)
    | (begin e ...+)
    | (call/cc e)
    | (apply e e)
    | (e e ...)
    | x
    | op
    | (quote dat) |#

;(define (compile-time-errors exp)
 ; `(letrec*
 ; ((member?
 ;   (lambda (v lst) (letrec* () (if (eqv? '() lst) (letrec* () '#f) (if '#t (let ((else lst)) (letrec* () (if (eqv? v (car lst)) '#t (member? v (cdr lst))))) (raise '"Match failed")))))))
 ; ,(cte exp)))
      
(define (cte exp)
  ;(pretty-print exp)
  (match exp
    [`(/ ,e1 ,e2)
     `(guard
       (val
        [(eqv? val '0) '"division by 0 error"]
        [else (/ ,(cte e1) ,(cte e2))])
       (raise ,(cte e2)))]
        
    [`(letrec* ([,x ,es] ...) ,e1)
    ; (pretty-print e1)
      `(letrec* ,(map (lambda (x2 e2) (list x2 (cte e2))) x es) ,(cte e1))]
    
    [`(letrec ([,x ,es] ...) ,e1)
    
     
     ;(pretty-print "letrec")
     `(letrec ,(map (lambda (x2 e2) (list x2 (cte e2))) x es) ,(cte e1))]

    [`(let ([,x ,es] ...) ,e1)
    ; (pretty-print "let")
     `(let ,(map (lambda (x2 e2) (list x2 (cte e2))) x es) ,(cte e1))]
    
    [`(let* ([,x ,es] ...) ,e1)
    ; (pretty-print "let")
    `(let* ,(map (lambda (x2 e2) (list x2 (cte e2))) x es) ,(cte e1))]
    
    [`(let ,x ([,x1 ,es] ...) ,e1)
    ; (pretty-print e1)
     `(let ,x ,(map (lambda (x2 e2) (list x2 (cte e2))) x1 es) ,(cte e1))]

    [`(lambda (,xs ...) ,e1)
     `(lambda all_args (let ([arg-count (length all_args)] [expected (length ,(list 'quote xs))])
                         (guard
                          (val
                           [(eqv? val expected) (apply (lambda (,@xs) ,(cte e1)) all_args)]
                           [(< val expected) '"too few args were provided for a user defined lambda"]
                           [(> val expected) '"too many args were provided for a user defined lambda"])
                          (raise arg-count))))]

     
    [`(lambda (,x ... . ,x2) ,e1)
     `(lambda (,@x . ,x2) ,(cte e1))]
                        
    [`(lambda ,x ,e1)
     ;(pretty-print "urm")
     `(lambda ,x ,(cte e1))]

    [`(dynamic-wind ,e1 ,e2 ,e3)
     `(guard
       (val1
        [(procedure? val1)
         (guard
          (val2
           [(procedure? val2)
            (guard
             (val3
              [(procedure? val3) (dynamic-wind val1 val2 val3)]
              [else '"dynamic-wind supplied with non-procedure"])
             (raise ,(cte e3)))]
           [else '"dynamic-wind supplied with non-procedure"])
          (raise ,(cte e2)))] 
        [else '"dynamic-wind supplied with non-procedure"])
       (raise ,(cte e1)))]

    [`(guard (,x ,cond ...) ,e1)
     `(guard (,x ,@(map cte-cond cond)) ,(cte e1))]
    
    [`(raise ,e1)
     `(raise ,(cte e1))]

    [`(delay ,e1)
     `(delay ,(cte e1))]

    [`(force ,e1)
     `(force ,(cte e1))]

    [`(and ,es ...)
     `(and ,@(map cte es))]

    [`(or ,es ...)
     `(or ,@(map cte es))]

    [`(cond ,cond-clause ...)
     `(cond ,@(map cte-cond cond-clause))]

    [`(case ,e1 ,case-clause ...)
     `(case ,(cte e1) ,@(map cte-case case-clause))]

    [`(if ,e1 ,e2 ,e3)
     `(if ,(cte e1) ,(cte e2) ,(cte e3))]
    
    [`(when ,e1 ,e2)
     `(when ,(cte e1) ,(cte e2))]

    [`(unless ,e1 ,e2)
     `(unless ,(cte e1) ,(cte e2))]

    [`(set! ,x ,e1)
    
     `(set! ,x ,(cte e1))]

    [`(begin ,es ...)
     `(begin ,@(map cte es))]

    [`(call/cc ,e1)
     `(call/cc ,(cte e1))]

    [`(apply ,es ...)
     `(guard
       (val
        [(procedure? val) (apply ,@(map cte es))]
        [else '"non function applied"])
       (raise ,(car es)))]
        
     ;`(apply ,(cte e1) ,(cte e2))]

    [(? symbol? x)
     x]

    [(? prim? op)
     op]

    [`(quote ,dat)
     (list 'quote dat)]

    [(? number? dat)
     dat]
    
    [`(,es ...)
     ;(pretty-print es)
    ; `(guard
     ;  (val
      ;  [(procedure? val) ,(map cte es)]
       ; [else '"error: non-function applied"])
      ; (raise ,(cte (car es))))]

     (map cte es)]
     
     ;`(if (procedure? ,(cte (car es)))
      ;    (map cte es)]
        ;  (halt '"error: non-function applied"))]    
     ))

(define (cte-cond exp)
  ;(pretty-print exp)
  (match exp
    [`(else ,e)
     `(else ,(cte e))]

    [`(,e)
     `(,(cte e))]
    
    [`(,e1 ,es ...)
     ;(pretty-print e1)
     `(,(cte e1) ,(cte es))]

    ))

(define (cte-case exp)
  (match exp
    [`(else ,e)
     `(else ,(cte e))]

    [`((,(? datum? dats) ...) ,e1)
     `(,dats ,(cte e1))]

    ))

  
