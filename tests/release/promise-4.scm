

(prim foldl (lambda args (apply-prim + args))
      '0
      (prim map (lambda (b) (if b '1 '2)) 
            (prim map (lambda arg (apply-prim number? arg))
                  (prim list
                   '#f
                   '#t
                   '7
                   (prim list)
                   (prim list '() '())
                   '#()
                   '#(0 1)
                   'yes))))
