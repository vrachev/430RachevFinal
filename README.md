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










   

