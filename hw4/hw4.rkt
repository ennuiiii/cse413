#lang racket

;; Homework # 4
;; Name: Qiubai Yu
;; Stu#: 1663777
;; Uwid: qiubay

(provide (all-defined-out))
(provide red-blue)
(provide take)
(provide combm)

;; Problem # 1
(define red-blue (lambda () (cons "red" auxrb)))

(define auxrb (lambda () (cons "blue" red-blue)))

;; Problem # 2
(define (take st n)
  (cond [(<= n 0) '()]
        [(null? st) '()]
        [else (cons (car (st)) (take (cdr (st)) (- n 1)))]))

;; Problem # 3
(define combm
  (letrec ([memo null]
           [fact (lambda (x acc)
                (if (or (= x 0) (= x 1))
                    acc
                    (fact (- x 1) (* x acc))))]
           [f (lambda (n k)
                (if (or (negative? n) (negative? k) (< n k))
                    "error"
                    (let ([ans (assoc (list n k) memo)])
                      (if ans
                          (cdr ans)
                          (let ([new-ans (/ (fact n 1) (* (fact k 1) (fact (- n k) 1)))])
                            (begin
                              (set! memo (cons (cons (list n k) new-ans) memo))
                              new-ans))))))])
    f))


