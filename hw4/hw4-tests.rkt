#lang racket

(require rackunit)
(require "hw4.rkt")

;; red-blue testing
(check-equal? (car (red-blue)) "red" "check red-blue basic functionality")
(check-equal? (car ((cdr (red-blue)))) "blue" "check red-blue basic functionality")
(check-equal? (car ((cdr ((cdr (red-blue)))))) "red" "check recursive case1")
(check-equal? (car ((cdr ((cdr ((cdr (red-blue)))))))) "blue" "check recursive case2")
(check-equal? (procedure? (cdr (red-blue))) #t "check stream definition case1")
(check-equal? (procedure? (cdr ((cdr (red-blue))))) #t "check stream definition case2")

;; take testing
(check-equal? (take red-blue 0) '() "test base case")
(check-equal? (take red-blue -1) '() "handle illegal input when n is negative")
(check-equal? (take '() 1000) '() "handle illegal input when stream is null")
(check-equal? (take red-blue 4) '("red" "blue" "red" "blue") "check take functionality")

;; combm testing
(check-equal? (combm 10 1) 10 "check combm functionality")
(check-equal? (combm 10 100) "error" "check illegal case1")
(check-equal? (combm 10 -3) "error" "check illegal case2")
