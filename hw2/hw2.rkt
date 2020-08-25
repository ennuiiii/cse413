;; HW#2
;; Qiubai Yu
;; qiubay
;; 1663777
#lang racket

(provide (all-defined-out))

;; PART II
;; Question # 1

;; part a
(define (lengtht lst)
  (auxlength lst 0))

;; helper method for part a
(define (auxlength lst counter)
  (if (null? lst)
      counter
      (auxlength (cdr lst) (+ 1 counter))))

;; part b
(define (lengtht2 lst)
  (letrec ([aux (lambda (lst counter)
                  (if (null? lst)
                      counter
                      (aux (cdr lst) (+ 1 counter))))])
    (aux lst 0)))

;; Question # 2

;; x(number): an arbitrary number
;; coeff(list): contains the coefficients from ordered 0 to ordered n
;; and by default, the coeff contains at least one element
(define (poly x coeff)
  (auxpoly 0 1 x coeff))

;; helper function
;; sum(number): the sum of all previous operations' results
;; prevX(number): keep track of the x^n instead of compute it again
(define (auxpoly sum prevX x coeff)
  (if (null? coeff)
      sum
      (auxpoly (+ sum (* prevX (car coeff)))
               (* prevX x)
               x
               (cdr coeff))))

;; Question # 3

;; lst(list): a list of functions
;; x(number) : an arbitrary number
(define (apply-all lst x)
  (if (null? lst)
      '()
      (cons ((car lst) x) (apply-all (cdr lst) x))))

;; Question # 4
(define all-are
  (lambda (f)
    (lambda (lst)
      (if (null? lst)
          #t
          (and (f (car lst)) ((all-are f) (cdr lst)))))))

;; PART III
;; Question # 1

(define (make-expr left-op operator right-op)
  (list left-op operator right-op))
(define (operator lst)
  (cadr lst))
(define (left-op lst)
  (car lst))
(define (right-op lst)
  (caddr lst))

;; Question # 2

;; preorder
(define (preorder expr-tree)
  (if (null? expr-tree)
      '()
      (if (list? expr-tree)
          (append (cons (operator expr-tree) (preorder (left-op expr-tree))) (preorder (right-op expr-tree)))
          (cons expr-tree '()))))

;; inorder
(define (inorder expr-tree)
  (if (null? expr-tree)
      '()
      (if (list? expr-tree)
          (append (append (inorder (left-op expr-tree)) (cons (operator expr-tree) '())) (inorder (right-op expr-tree)))
          (cons expr-tree '()))))

;; postorder
(define (postorder expr-tree)
  (if (null? expr-tree)
      '()
      (if (list? expr-tree)
          (append (append (postorder (left-op expr-tree)) (postorder (right-op expr-tree))) (cons (operator expr-tree) '()))
          (cons expr-tree '()))))

;; Question # 3
(define (eval-tree expr-tree)
  (if (null? expr-tree)
      0
      (if (and (not (list? (left-op expr-tree))) (not (list? (right-op expr-tree))))
          ((operator expr-tree) (left-op expr-tree) (right-op expr-tree))
          ((operator expr-tree) (eval-tree (left-op expr-tree)) (eval-tree (right-op expr-tree))))))
  
;; Question # 4

(define (map-leaves f expr-tree)
  (if (null? expr-tree)
      '()
      (if (not (list? expr-tree))
          (f expr-tree)
          (make-expr (map-leaves f (left-op expr-tree)) (operator expr-tree) (map-leaves f (right-op expr-tree))))))

