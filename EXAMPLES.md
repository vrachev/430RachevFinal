Output for /tests/ (these all pass, and test correct input): 

```
racket tests.rkt all
Running llvm (scm) test #<path:tests/public/amb.scm>
header.cpp:127:21: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
    printf("%lu\n", i);
            ~~~     ^
            %llu
header.cpp:264:55: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
        printf("(print.. v); unrecognized value %lu", v);
                                                ~~~   ^
                                                %llu
header.cpp:311:53: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
        printf("(print v); unrecognized value %lu", v);
                                              ~~~   ^
                                              %llu
3 warnings generated.
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: (solution 3 4 5)
Test Passed! Values before and after compilation are: ((solution 3 4 5) and (solution 3 4 5))

Running llvm (scm) test #<path:tests/public/apply-1.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: 50
Test Passed! Values before and after compilation are: (50 and 50)

Running llvm (scm) test #<path:tests/public/case-0.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: big
Test Passed! Values before and after compilation are: (big and big)

Running llvm (scm) test #<path:tests/public/cond-0.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: lt
Test Passed! Values before and after compilation are: (lt and lt)

Running llvm (scm) test #<path:tests/public/exceptions-continuations.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: 26
Test Passed! Values before and after compilation are: (26 and 26)

Running llvm (scm) test #<path:tests/public/fib-cont.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: 233
Test Passed! Values before and after compilation are: (233 and 233)

Running llvm (scm) test #<path:tests/public/guard-3.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: 3
Test Passed! Values before and after compilation are: (3 and 3)

Running llvm (scm) test #<path:tests/public/guard-continuations.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: 3317863
Test Passed! Values before and after compilation are: (3317863 and 3317863)

Running llvm (scm) test #<path:tests/public/nqueens.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: 92
Test Passed! Values before and after compilation are: (92 and 92)

Running llvm (scm) test #<path:tests/release/promise-4.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: 15
Test Passed! Values before and after compilation are: (15 and 15)

Running llvm (scm) test #<path:tests/secret/promise-3.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: 29
Test Passed! Values before and after compilation are: (29 and 29)

Score on available tests (may not include release tests or private tests): 100.0%
```
Output for /tests-runtime-errors/div-by-zero/:

```
Running llvm (scm) test #<path:tests-runtime-errors/div-by-zero/SHOULDFAIL-divbyzero-0.scm>
header.cpp:127:21: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
    printf("%lu\n", i);
            ~~~     ^
            %llu
header.cpp:264:55: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
        printf("(print.. v); unrecognized value %lu", v);
                                                ~~~   ^
                                                %llu
header.cpp:311:53: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
        printf("(print v); unrecognized value %lu", v);
                                              ~~~   ^
                                              %llu
3 warnings generated.
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: division by 0 error
"Evaluation failed:"
(exn:fail:contract:divide-by-zero
 "/: division by zero"
 #<continuation-mark-set>)
'(begin
   (define x '1)
   (define z '10)
   (define b '10)
   (letrec ((k
             (letrec ((f
                       (lambda (n)
                         (if (eqv? z n)
                           (begin (set! z '0) (set! x '100) '110)
                           (begin (set! z '2) '212)))))
               (f b))))
     (/ k ((lambda (j) j) z))))
Test to-llvm-SHOULDFAIL-divbyzero-0 failed!
Running llvm (scm) test #<path:tests-runtime-errors/div-by-zero/SHOULDFAIL-divbyzero-1.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: division by 0 error
"Evaluation failed:"
(exn:fail:contract:divide-by-zero
 "/: division by zero"
 #<continuation-mark-set>)
'(begin
   (define (divide pair)
     (let ((fst (car (pair))) (scnd (cdr (pair)))) (/ fst scnd)))
   (define func
     (let ((scnd 0)) (let ((fst 900)) (divide (lambda () (cons fst scnd))))))
   func)
Test to-llvm-SHOULDFAIL-divbyzero-1 failed!
Running llvm (scm) test #<path:tests-runtime-errors/div-by-zero/divbyzero-0-control.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: 106
Test Passed! Values before and after compilation are: (106 and 106)

Running llvm (scm) test #<path:tests-runtime-errors/div-by-zero/divbyzero-1-control.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: 90
Test Passed! Values before and after compilation are: (90 and 90)

Score on available tests (may not include release tests or private tests): 50.0%
```

Output for /tests-runtime-errors/too-few-args/:

```
Running llvm (scm) test #<path:tests-runtime-errors/too-few-args/SHOULDFAIL-too-few-args-0.scm>
header.cpp:127:21: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
    printf("%lu\n", i);
            ~~~     ^
            %llu
header.cpp:264:55: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
        printf("(print.. v); unrecognized value %lu", v);
                                                ~~~   ^
                                                %llu
header.cpp:311:53: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
        printf("(print v); unrecognized value %lu", v);
                                              ~~~   ^
                                              %llu
3 warnings generated.
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: too few args were provided for a user defined lambda
"Evaluation failed:"
(exn:fail:contract:arity
 "f: arity mismatch;\n the expected number of arguments does not match the given number\n  expected: 3\n  given: 2\n  arguments...:\n   10\n   48"
 #<continuation-mark-set>)
'(begin
   (define z '10)
   (define b '11)
   (define x '12)
   (letrec ((k
             (letrec ((f (lambda (n j k) (cons (cons n j) k))))
               (f
                ((lambda (m) m) z)
                (letrec* ((arg ((lambda (x) (+ x x)) x))) (+ arg arg))))))
     k))
Test to-llvm-SHOULDFAIL-too-few-args-0 failed!
Running llvm (scm) test #<path:tests-runtime-errors/too-few-args/SHOULDFAIL-too-few-args-1.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: too few args were provided for a user defined lambda
"Evaluation failed:"
(exn:fail:contract:arity
 "func: arity mismatch;\n the expected number of arguments does not match the given number\n  expected: 1\n  given: 0"
 #<continuation-mark-set>)
'(begin
   (define m 'world)
   (letrec*
    ((z 'hello) (a (lambda (arg) (cons z arg))))
    (let ((func (lambda (x) (a x)))) (func))))
Test to-llvm-SHOULDFAIL-too-few-args-1 failed!
Running llvm (scm) test #<path:tests-runtime-errors/too-few-args/too-few-args-0-control.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: ((10 . 48) . 11)
Test Passed! Values before and after compilation are: (((10 . 48) . 11) and ((10 . 48) . 11))

Running llvm (scm) test #<path:tests-runtime-errors/too-few-args/too-few-args-1-control.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: (hello . world)
Test Passed! Values before and after compilation are: ((hello . world) and (hello . world))

Score on available tests (may not include release tests or private tests): 50.0%
```

Output for /tests-runtime-errors/too-many-args/:

```
Running llvm (scm) test #<path:tests-runtime-errors/too-many-args/SHOULDFAIL-too-many-args-0.scm>
header.cpp:127:21: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
    printf("%lu\n", i);
            ~~~     ^
            %llu
header.cpp:264:55: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
        printf("(print.. v); unrecognized value %lu", v);
                                                ~~~   ^
                                                %llu
header.cpp:311:53: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
        printf("(print v); unrecognized value %lu", v);
                                              ~~~   ^
                                              %llu
3 warnings generated.
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: too many args were provided for a user defined lambda
"Evaluation failed:"
(exn:fail:contract:arity
 "f: arity mismatch;\n the expected number of arguments does not match the given number\n  expected: 3\n  given: 4\n  arguments...:\n   10\n   48\n   11\n   22"
 #<continuation-mark-set>)
'(begin
   (define z '10)
   (define b '11)
   (define x '12)
   (letrec ((k
             (letrec ((f (lambda (n j k) (cons (cons n j) k))))
               (f
                ((lambda (m) m) z)
                (letrec* ((arg ((lambda (x) (+ x x)) x))) (+ arg arg))
                b
                (+ b b)))))
     k))
Test to-llvm-SHOULDFAIL-too-many-args-0 failed!
Running llvm (scm) test #<path:tests-runtime-errors/too-many-args/SHOULDFAIL-too-many-args-1.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: too many args were provided for a user defined lambda
"Evaluation failed:"
(exn:fail:contract:arity
 "func: arity mismatch;\n the expected number of arguments does not match the given number\n  expected: 1\n  given: 2\n  arguments...:\n   'world\n   'world"
 #<continuation-mark-set>)
'(begin
   (define m 'world)
   (letrec*
    ((z 'hello) (a (lambda (arg) (cons z arg))))
    (let ((func (lambda (x) (a x)))) (func m m))))
Test to-llvm-SHOULDFAIL-too-many-args-1 failed!
Running llvm (scm) test #<path:tests-runtime-errors/too-many-args/too-many-args-0-control.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: ((10 . 48) . 11)
Test Passed! Values before and after compilation are: (((10 . 48) . 11) and ((10 . 48) . 11))

Running llvm (scm) test #<path:tests-runtime-errors/too-many-args/too-many-args-1-control.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: (hello . world)
Test Passed! Values before and after compilation are: ((hello . world) and (hello . world))

Score on available tests (may not include release tests or private tests): 50.0%
```

Output for /tests-runtime-errors/non-func-apply/:

```
Running llvm (scm) test #<path:tests-runtime-errors/non-func-apply/SHOULDFAIL-non-func-apply-0.scm>
header.cpp:127:21: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
    printf("%lu\n", i);
            ~~~     ^
            %llu
header.cpp:264:55: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
        printf("(print.. v); unrecognized value %lu", v);
                                                ~~~   ^
                                                %llu
header.cpp:311:53: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
        printf("(print v); unrecognized value %lu", v);
                                              ~~~   ^
                                              %llu
3 warnings generated.
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: non function applied
"Evaluation failed:"
(exn:fail:contract
 "application: not a procedure;\n expected a procedure that can be applied to arguments\n  given: '(hello . world)\n  arguments...:\n   15\n   19"
 #<continuation-mark-set>)
'(begin
   (letrec ((k (lambda (x func) (apply func x))))
     (let ((f (cons 'hello 'world))) (letrec ((x '(15 19))) (k x f)))))
Test to-llvm-SHOULDFAIL-non-func-apply-0 failed!
Running llvm (scm) test #<path:tests-runtime-errors/non-func-apply/SHOULDFAIL-non-func-apply-1.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: non function applied
"Evaluation failed:"
(exn:fail:contract
 "application: not a procedure;\n expected a procedure that can be applied to arguments\n  given: 14\n  arguments...:\n   10\n   ''15"
 #<continuation-mark-set>)
'(begin
   (let ((func (letrec ((b '(25 11))) (apply (lambda (v x) (- v x)) b))))
     (apply func '(10 '15))))
Test to-llvm-SHOULDFAIL-non-func-apply-1 failed!
Running llvm (scm) test #<path:tests-runtime-errors/non-func-apply/non-func-apply-0-control.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: 34
Test Passed! Values before and after compilation are: (34 and 34)

Running llvm (scm) test #<path:tests-runtime-errors/non-func-apply/non-func-apply-1-control.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: 14
Test Passed! Values before and after compilation are: (14 and 14)

Score on available tests (may not include release tests or private tests): 50.0%
```

Output for /tests-runtime-errors/dynamic-wind-correct-args/:

```
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: dynamic-wind supplied with non-procedure
"Evaluation failed:"
(exn:fail:contract
 "dynamic-wind: contract violation\n  expected: (-> any)\n  given: #<procedure:...t/private/kw.rkt:446:14>\n  argument position: 1st\n  other arguments...:\n   7\n   #<procedure:...t/private/kw.rkt:446:14>"
 #<continuation-mark-set>)
'(begin (dynamic-wind (lambda (x) '5) '7 (lambda () '8)))
Test to-llvm-SHOULDFAIL-dynamic-wind-0 failed!
Running llvm (scm) test #<path:tests-runtime-errors/dynamic-wind-correct-args/SHOULDFAIL-dynamic-wind-1.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: dynamic-wind supplied with non-procedure
"Evaluation failed:"
(exn:fail:contract
 "dynamic-wind: contract violation\n  expected: (-> any)\n  given: #<procedure:...t/private/kw.rkt:446:14>\n  argument position: 1st\n  other arguments...:\n   #<procedure:...t/private/kw.rkt:446:14>\n   8"
 #<continuation-mark-set>)
'(begin (dynamic-wind (lambda (x) '5) (lambda (x) '7) '8))
Test to-llvm-SHOULDFAIL-dynamic-wind-1 failed!
Running llvm (scm) test #<path:tests-runtime-errors/dynamic-wind-correct-args/SHOULDFAIL-dynamic-wind-2.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: dynamic-wind supplied with non-procedure
"Evaluation failed:"
(exn:fail:contract
 "dynamic-wind: contract violation\n  expected: (-> any)\n  given: 5\n  argument position: 1st\n  other arguments...:\n   #<procedure:...t/private/kw.rkt:446:14>\n   #<procedure:...t/private/kw.rkt:446:14>"
 #<continuation-mark-set>)
'(begin (dynamic-wind '5 (lambda () '7) (lambda () '8)))
Test to-llvm-SHOULDFAIL-dynamic-wind-2 failed!
Score on available tests (may not include release tests or private tests): 0%
```



