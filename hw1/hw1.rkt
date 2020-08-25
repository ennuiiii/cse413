;; Name: Qiubai Yu
;; UWNetid: qiubay
;; student id: 1663777
#lang racket

(provide (all-defined-out))

;; Question #1

;; helper method factorial
(define (fact n)
  (if (< n 0)
      (error 'failed)
      (if (< n 2)
          1
          (* n (fact (- n 1))))))

(define (comb n k)
  (if (< n k)
      (error 'failed)
      (/ (fact n) (* (fact k) (fact (- n k))))))

;; Question #2

;; helper method return the length of the list
(define (length lst)
  (if (null? lst)
  0
  (+ 1 (length (cdr lst)))))

;; helper method return whether the list is not empty
(define (isNotEmpty lst)
  (if (= 0 (length lst))
      #f
      #t))

(define (zip lst1 lst2)
  (cond [(and (isNotEmpty lst1) (isNotEmpty lst2))
         (append (cons (car lst1) (cons(car lst2) '())) (zip (cdr lst1) (cdr lst2)))]
        [(isNotEmpty lst1) (append lst1)]
        [else (append lst2)]))

;; Question #3

;; helper method takes alternate entries of a list
(define (alternate lst)
  (cond [(> (length lst) 2) (cons (car lst) (alternate (cddr lst)))]
        [(or (= (length lst) 1) (= (length lst) 2)) (cons (car lst) '())]
        [else '()]))

(define (unzip lst)
  (if (null? lst)
      '(() ())
      (list (alternate lst) (alternate (cdr lst)))))

;; Question #4

;; helper method
(define (duplicate lst)
  (if (or (= (car lst) 0) (< (car lst) 0))
      '()
      (append (cdr lst) (duplicate (cons (- (car lst) 1) (cdr lst))))))

(define (expand lst)
  (if (null? lst)
      '()
      (if (list? (car lst))
          (append (duplicate (car lst)) (expand (cdr lst)))
          (cons (car lst) (expand (cdr lst))))))

;; Question #5

;; part a
(define (value node)
  (if (null? node)
      '()
      (car node)))

(define (left node)
  (if (null? node)
      '()
      (cadr node)))

(define (right node)
  (if (null? node)
      '()
      (caddr node)))

;; part b
(define (size node)
  (if (null? node)
      0
      (+ 1 (+ (size (left node)) (size (right node))))))

;; part c
(define (contains item tree)
  (if (null? tree)
      #f
      (if (equal? item (car tree))
          #t
          (or (contains item (cadr tree)) (contains item (caddr tree))))))

;; part d
(define (leaves tree)
  (if (and (equal? (left tree) '()) (equal? (right tree) '()))
      (if (not (null? (value tree)))
          (cons (value tree) '())
          '())
      (append (leaves (left tree)) (leaves (right tree)))))
 
;; part e (left < right)
(define (isBST tree)
  (if (and (null? (left tree)) (null? (right tree)))
      #t
      (cond [(and (not (null? (left tree))) (not (null? (right tree))))
             (and (< (value (left tree)) (value tree)) (> (value (right tree)) (value tree))
                  (isBST (left tree)) (isBST (right tree)))]
            [(not (null? (left tree)))
             (and (< (value (left tree)) (value tree)) (isBST (left tree)))]
            [else (and (> (value (right tree)) (value tree)) (isBST (right tree)))])))
          
