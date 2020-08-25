#lang racket

(provide diff)
;; Homework # 3
;; Qiubai Yu
;; 1663777
;; qiubay

(define E1 '(+ (* 2 x) 4))
(define E2 '(+ x (* x x)))
(define E3 '(+ (* 3 x) (* 4 y) (* 6 (expt x 3))))
(define E4 '(expt x 4)) 

(define (get-op E)
  (if (null? E)
      '()
      (car E)))
      
(define (find-function operator diff-dispatch)
  (if (equal? operator (car (car diff-dispatch)))
      (car (cdr (car diff-dispatch)))
      (find-function operator (cdr diff-dispatch))))
      
(define (diff x E)
  (if (null? E)
      empty
      (cond [(number? E) 0]
            [(equal? E x) 1]
            [(not (list? E)) 0]
            [else ((find-function (get-op E) diff-dispatch) x (cdr E))])))

(define (diff-sum x E)
  (if (null? E)
      empty
      (append '(+) (auxsum x E))))

(define (auxsum x E)
  (if (null? E)
      empty
      (append (list (diff x (car E))) (auxsum x (cdr E)))))

(define (diff-product x E)
  (list '+ (list '* (diff x (car E)) (car (cdr E))) (list '* (car E) (diff x (car (cdr E))))));

(define (diff-expt x E)
  (list '* (car (cdr E)) (list 'expt (car E) (- (car (cdr E)) 1)) (diff x (car E))))

;; Dispatch Table of supported operators
(define diff-dispatch
  (list (list '+ diff-sum)
        (list '* diff-product)
        (list 'expt diff-expt)))