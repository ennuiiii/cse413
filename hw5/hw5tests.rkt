;; CSE413 19wi, Programming Languages, Homework 5
;; Qiubai Yu
;; 1663777

#lang racket

(require "hw5.rkt")

; This file uses Racket's unit-testing framework.

; Note we have provided [only] 3 tests, but you can't run them until do some of the assignment.
; You will want to add more tests.

(require rackunit)

(define tests
  (test-suite
   "Homework 5 Tests"

   ;; tests provided
   (check-equal? (eval-exp (add (int 2) (int 2))) (int 4) "add simple test")

   (check-exn (lambda (x) (string=? (exn-message x) "MUPL addition applied to non-number"))
              (lambda () (eval-exp (add (int 2) (munit))))
              "add bad argument")

   (check-equal? (mupllist->racketlist
                  (eval-exp (call (call mupl-all-gt (int 9))
                                  (racketlist->mupllist 
                                   (list (int 10) (int 9) (int 15))))))
                 (list (int 10) (int 15))
                 "provided combined test using problems 1, 2, and 4")

   ;; check isgreater functionality
   (check-equal? (eval-exp (isgreater (int 3) (int 0))) (int 1) "check isgreater given ok input")

   (check-exn (lambda (x) (string=? (exn-message x) "MUPL isgreater applied to non-number"))
              (lambda () (eval-exp (isgreater (munit) (int 100))))
              "check isgreater error handling")

   ;; check ifnz functionality
   (check-equal? (eval-exp (ifnz (int 0) (int 1) (int 2))) (int 2) "check ifnz given ok input_1")

   (check-equal? (eval-exp (ifnz (int 3242) (int 1) (int 2))) (int 1) "check ifnz given ok input_2")

   (check-exn (lambda (x) (string=? (exn-message x) "MUPL ifnz condition e1 type incorrect"))
              (lambda () (eval-exp (ifnz (munit) (int 1) (int 1))))
              "check ifnz error handling")

   ;; check fun functionality
   (check-equal? (eval-exp (fun null "x" (var "x"))) (closure '() (fun '() "x" (var "x"))) "check eval fun give closure")

   ;; check mlet functionality
   (check-equal? (eval-exp (mlet "temp" (int 3) (add (var "temp") (int 3)))) (int 6) "check mlet functionality")

   ;; check call functionality
   (check-equal? (eval-exp (call (closure '() (fun "opt" "x" (add (var "x") (int 1)))) (int 1))) (int 2)
                 "check call given ok input")

   (check-exn (lambda (x) (string=? (exn-message x) "First argument is non-closure"))
              (lambda () (eval-exp (call (munit) (int 0))))
              "check call error handling")

   ;; check apair functionality
   (check-equal? (eval-exp (apair (add (int 1) (int 3)) (add (int 2) (int 5)))) (apair (int 4) (int 7))
                 "check apair given ok input")

   ;; check first & second functionality
   (check-equal? (eval-exp (first (apair (add (int 1) (int 3)) (add (int 2) (int 5))))) (int 4)
                 "check first given ok input")

   (check-equal? (eval-exp (second (apair (add (int 1) (int 3)) (add (int 2) (int 5))))) (int 7)
                 "check second given ok input")

   (check-exn (lambda (x) (string=? (exn-message x) "MUPL first applied to not-apair"))
              (lambda () (eval-exp (first (add (int 1) (int 2)))))
              "check first error handling")

   (check-exn (lambda (x) (string=? (exn-message x) "MUPL second applied to not-apair"))
              (lambda () (eval-exp (second (add (int 1) (int 2)))))
              "check second error handling")

   ;; check ismunit functionality
   (check-equal? (eval-exp (ismunit (munit))) (int 1) "check ismunit given munit")

   (check-equal? (eval-exp (ismunit (int 1))) (int 0) "check ismunit given not munit")

   ;; check ifmunit functionality
   (check-equal? (eval-exp (ifmunit (munit) (int 1) (int 2))) (int 1) "check basic functionality")

   (check-equal? (eval-exp (ifmunit (second (apair (int 1) (munit))) (int 1) (int 2))) (int 1)
                 "check whether evaluate e1")

   ;; check mlet* functionality
   (check-equal? (eval-exp (mlet* (list (cons "a" (int 0))
                                        (cons "b" (int 1)))
                                  (isgreater (var "a") (var "b"))))
                 (int 0)
                 "check mlet* functionality")

   ;; check ifeq functionality
   (check-equal? (eval-exp (ifeq (int 1) (int 3) (int 3) (int 5))) (int 5)
                 "check simple input_1")

   (check-equal? (eval-exp (ifeq (int 1) (int 1) (int 3) (int 5))) (int 3)
                 "check simple input_2")

   (check-equal? (eval-exp (ifeq (add (int 3) (int 7)) (add (int 6) (int 4))
                                 (int 3) (int 5))) (int 3)
                 "check ifeq whether evaluate e1 e2")
   ))


(require rackunit/text-ui)
;; runs the test
(run-tests tests)