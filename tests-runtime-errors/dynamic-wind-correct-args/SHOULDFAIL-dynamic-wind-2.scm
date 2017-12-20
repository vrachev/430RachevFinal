; first exp is a var instead of a procedure
; result in dyn wind error

(dynamic-wind '5 (lambda () '7) (lambda () '8))