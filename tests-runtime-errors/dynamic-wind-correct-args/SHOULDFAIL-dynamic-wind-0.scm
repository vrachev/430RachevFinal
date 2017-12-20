; middle exp is a var instead of a procedure
; result in dyn wind error

(dynamic-wind (lambda (x) '5) '7 (lambda () '8))