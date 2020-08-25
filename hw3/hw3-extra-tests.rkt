#lang racket

(require rackunit/text-ui)

(define file-tests
  (test-suite
   "Tests for hw3.rkt"

   ;; checking base cases
   (check-equal? (diff 'x 1) 0 "diff a constant")

   (check-equal? (diff 'x 'x) 1 "diff x itself")

   (check-equal? (diff 'x 'y) 0 "diff other symbol that is not x")

   (check-equal? (diff 'x 'sadkfnasdlfn) 0 "diff another complex symbol")

   ;; checking addition functionality
   (check-equal? (diff 'x '(+ 1 2)) '(+ 0 0) "diff simple numbers' addition")

   (check-equal? (diff 'x '(+ x yfksld)) '(+ 1 0) "diff simple symbols' addition")

   (check-equal? (diff 'x '(+ (+ x 1) (+ 3 x))) '(+ (+ 1 0) (+ 0 1)) "diff simple expressions' addition")

   (check-equal? (diff 'x '(+ 1 2 3 4 5 6)) '(+ 0 0 0 0 0 0) "diff multiple numbers' addition")

   (check-equal? (diff 'x '(+ x y asdlfk x)) '(+ 1 0 0 1) "diff multiple characters' addition")

   (check-equal? (diff 'x '(+ (+ x y) (+ 1 3) (+ x x))) '(+ (+ 1 0) (+ 0 0) (+ 1 1)) "diff multiple expressions' addition")

   (check-equal? (diff 'x '(+ 1 y 2348923 x)) '(+ 0 0 0 1) "diff mix of numbers & symbols addition")

   (check-equal? (diff 'x '(+ 1 (+ x x) 0 (+ no no))) '(+ 0 (+ 1 1) 0 (+ 0 0)) "diff mix of numbers & expressions addition")

   (check-equal? (diff 'x '(+ x (+ x x) y (+ 1 x y))) '(+ 1 (+ 1 1) 0 (+ 0 1 0)) "diff mix of symbols & expressions addition")

   (check-equal? (diff 'x '(+ 1 x (+ x x))) '(+ 0 1 (+ 1 1)) "diff mix of symbol & number & expression addition") 

   ;; checking product functionality
   (check-equal? (diff 'x '(* 1 x)) '(+ (* 0 x) (* 1 1)) "diff number & symbol production")

   (check-equal? (diff 'x '(* 1 (* x y))) '(+ (* 0 (* x y)) (* 1 (+ (* 1 y) (* x 0)))) "diff number & expression product")

   (check-equal? (diff 'x '(* y (* x y))) '(+ (* 0 (* x y)) (* y (+ (* 1 y) (* x 0)))) "diff symbol & expression product")

   (check-equal? (diff 'x '(* 1 1)) '(+ (* 0 1) (* 1 0)) "diff 2 numbers production")

   (check-equal? (diff 'x '(* x y)) '(+ (* 1 y) (* x 0)) "diff 2 symbols production")

   (check-equal? (diff 'x '(* (* 1 1) (* x x))) '(+ (* (+ (* 0 1) (* 1 0)) (* x x)) (* (* 1 1) (+ (* 1 x) (* x 1))))
                 "diff 2 expressions product")

   ;; checking exponential functionality
   (check-equal? (diff 'x '(expt x 3)) '(* 3 (expt x 2) 1) "diff exponential base x")

   (check-equal? (diff 'x '(expt y 3)) '(* 3 (expt y 2) 0) "diff exponential base other symbol")

   (check-equal? (diff 'x '(expt (* x x) 3)) '(* 3 (expt (* x x) 2) (+ (* 1 x) (* x 1))) "diff exponential base expression")
   ))

(run-tests file-tests)