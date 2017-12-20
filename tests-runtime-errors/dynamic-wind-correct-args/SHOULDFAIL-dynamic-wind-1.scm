; last exp is a var instead of a procedure
; result in dyn wind error

(dynamic-wind (lambda (x) '5) (lambda (x) '7) '8)