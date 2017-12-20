# CMSC430 Final Project

This project combines the reference solutions to projects 2-5 to create a functional compiler that takes input scheme code and outputs an executable. 

Academic integrity pledge:

I pledge on my honor that I have not given or received any unauthorized assistance on this examination (or assignment).

Vlad Rachev

## Part 1

To show every test: `racket tests.rkt`

To run every test: `racket tests.rkt all`

To run specific test: `racket tests.rkt >TESTNAME<`

All tests with correct input are located inside /tests/. Most tests are inside /tests/public, however, there is a single test in both release and secret because github was not letting me add empty folders. (Alternatively I could have slightly changed the directory structure but I'm running out of time).

Here is the list of tests in /tests/ (most if not all were taken from previous projects):

1. amb.scm
2. exceptions-continuations.scm
3. fib-cont.scm
4. guard-continuations.scm
5. nqueens.scm
6. case-0.scm
7. cond-0.scm
8. guard-3.scm
9. apply-1.scm
10. promise-3.scm
11. promise-4.scm

NOTE: when running `racket tests.rkt all`, only 63.33% of the tests will pass. This is because it is testing these 11 (which pass) + tests for part 2. I will explain the testing process for the runtime errors of part 2 in the later section. 

All tests in /tests/ pass on my local machine (mac osx), and should pass when run by instructors. Output of all tests in /tests/ is found in EXAMPLES.md. 

Output of a sample PASSING test: 

```Running llvm (scm) test #<path:tests/public/exceptions-continuations.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: 26
Test Passed! Values before and after compilation are: (26 and 26)
```

This is the method that runs when testing a program, it is found in utils.rkt:
```
(define (test-full-compiler top-level-prog llvm-val)
    (define val (eval-top-level top-level-prog))

    (if (equal? val llvm-val)
      (begin
        (display (format "Test Passed! Values before and after compilation are: (~a and ~a)\n\n" val llvm-val))
        #t)
      (begin
        (display (format "Test-full-compiler: two different values (~a and ~a) before and after compilation.\n\n"
                         val llvm-val))
        #f)))
```

It checks the value of (eval-llvm llvm-prog) and (eval-top-level top-level-prog). 

These are the relevant lines of the method that calls the testing method, found in tests.rkt:

```
(define llvm-e (proc->llvm (closure-convert (cps-convert (anf-convert (alphatize (assignment-convert (simplify-ir (desugar (cte (top-level top-level-e)))))))))))

(define llvm-val (eval-llvm llvm-e))
(display (format "TEST RUNNING:\nTHE LLVM VALUE FOR THIS TEST IS: ~a\n" llvm-val))

(test-full-compiler top-level-e llvm-val) 
```

Before the result of the test is shown, the result of the llvm-value is displayed. This will be important for part 2, where tests will fail, but the llvm-val will be a printed error message. 


Here are the prims I have tested for (I will use haskell like type declarations)

It may not be an exhaustive list:

null? :: v -> Boolean

\= :: v -> v -> Boolean

\< :: v -> v -> Boolean

\<= :: v -> v -> Boolean

\> :: v -> v -> Boolean

\>= :: v -> v -> Boolean

\+ :: number? -> number? -> number?

\- :: number? -> number? -> number?

\/ :: number? -> number? -> number?

\* :: number? -> number? -> number?

cons :: v -> v -> (v . v)

car :: (v . v) -> v (first one)

cdr :: (v . v) -> v (last one)

number? :: v -> Boolean

list :: (v ...) -> (list v)

map :: (v->w) -> [v] -> [w]

foldl :: (v -> w -> v) -> w -> t v -> w

append :: (list v) -> (list v) > (list v)

not :: Boolean -> Boolean

eqv? :: v -> v -> Boolean

procedure? :: v -> Boolean 


## Part 2

Before talking about what I implemented, I'll explaing the testing process. Because I don't have time to implement a proper tests that accept failure, all of the runtime error tests will fail. These tests are found in /tests-runtime-errors/, in the 5 subfolders (each named for the error they test). Because tests.rkt compares `(eval-top-level e)` and `(eval-llvm e)`, the tests with runtime errors fail for the `(eval-top-level e)` evaluation. However, they successfuly return an error message in `(eval-llvm e)`. Because of this, tests.rkt will print the result of `(eval-llvm e)` before the test is complete, which will display the correct error message. Additionally, all tests that fail due to a runtime error have `SHOULDFAIL` as part of their path. I have also included control tests, which are identical to the failing ones, except with slightly modified code that is valid and returns a concrete value. These have `control` in their path and will pass. 

A sample of a failing test (but that succesfully returns an `(eval-llvm e)` result:
```
Running llvm (scm) test #<path:tests-runtime-errors/too-many-args/SHOULDFAIL-too-many-args-0.scm>
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
```

Note the `THE LLVM VALUE FOR THIS TEST IS: too many args were provided for a user defined lambda`

The value of the `:` is the error message printed by the binary produced by the test.

A sample of the control test:

```
Running llvm (scm) test #<path:tests-runtime-errors/too-many-args/too-many-args-1-control.scm>
TEST RUNNING:
THE LLVM VALUE FOR THIS TEST IS: (hello . world)
Test Passed! Values before and after compilation are: ((hello . world) and (hello . world))
```

I have included the output of all tests in EXAMPLES.md

Here are the 5 errors for which I have implemented exception-handling.
The implementations are done in a seperate pass called cte, which is run in between desugar and top-level 
(i.e. `... (desugar (cte (top-level ...`

All 5 errors are implemented with guards. The value is raised, and if it is an error, the error is printed, 
otherwise behaves as if input as normal. 

1. Divide by zero. 

2. User defined lambdas with too many args

3. User defined lambdas with too few args

4. Non function applied (i.e. (apply '5 '(1 2 3)) will return an error)

5. Dynamic-wind handed non-procedures (i.e. (dynamic-wind '5 (lambda () '6) (lambda () '7)) will return an error because '5 is not a procedure

I do not support the other runtime errors shown in the example, such as un-bound letrec/letrec* variables and memory-cap.









   

