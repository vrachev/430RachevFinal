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



Output for /tests-runtime-errors/too-many-args/:

Output for /tests-runtime-errors/non-func-apply/:

Output for /tests-runtime-errors/dynamic-wind-correct-args/:



