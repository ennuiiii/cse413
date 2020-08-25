Welcome to DrRacket, version 7.1 [3m].
Language: racket, with debugging; memory limit: 128 MB.
> ;; testing part2 problem1
;; define some tests
(define 21test1 '())
> (define 21test2 '(a b c))
> (define 21test3 '((a b) (a b c)))
> ;; testing lengtht
(lengtht 21test1)
0
> (lengtht 21test2)
3
> (lengtht 21test3)
2
> ;; testing lengtht2
(lengtht2 21test1)
0
> (lengtht2 21test2)
3
> (lengtht2 21test3)
2
> ;; testing part2 problem2
(define 22test1 '())
> (define 22test2 '(3))
> (define 22test3 '(3 5 6 7))
> ;; take any arbitrary x
;;let x = 0
(poly 0 22test1)
0
> (poly 0 22test2)
3
> (poly 0 22test3)
3
> ;;let x be a non-zero number, suppose it's 2
(poly 2 22test1)
0
> (poly 2 22test2)
3
> (poly 2 22test3)
93
> ;; testing part2 problem3
;;define some functions first
(define square (lambda (x) (* x x)))
define-values: assignment disallowed;
 cannot re-define a constant
  constant: square
> square
#<procedure:square>
> cube
#<procedure:cube>
> teststat
'(#<procedure:square> #<procedure:cube>)
> ;; take any arbitrary x, suppose x = 3
;; test if given a null list
(apply-all '() 3)
'()
> (apply-all teststat 3)
'(9 27)
> ;; testing part2 problem4
;; (all-are test) should be a procedure
;; check
(all-are positive?)
#<procedure:...p/cse413/hw2.rkt:69:4>
> ;; seems correct, check the functionality of the function
;; take arbitrary list
((all-are positive?) '(2 3 4 5 6))
#t
> ((all-are positive?) '(1 4 5 56 -3))
#f
> ;; testing part3
;; testing make-expr
(define simple (make-expr 1 + 3))
> simple
'(1 #<procedure:+> 3)
> (define complex (make-expr (make-expr 6 * 3) + (make-expr 5 - 2)))
> complex
'((6 #<procedure:*> 3)
  #<procedure:+>
  (5 #<procedure:-> 2))
> ;; seems working
;; test operator
(operator simple)
#<procedure:+>
> (operator complex)
#<procedure:+>
> ;;test left-op and right-op
;; right/left-op leaf should be an error
(left-op simple)
1
> (left-op (left-op simple))
. . car: contract violation
  expected: pair?
  given: 1
> (left-op complex)
'(6 #<procedure:*> 3)
> (right-op simple)
3
> (right-op (right-op simple))
. . caddr: contract violation
  expected: (cons/c (cons/c any/c pair?) any/c)
  given: 3
> (right-op complex)
'(5 #<procedure:-> 2)
> ;; seems correct
;; testing part2
;; testing given empty expr-tree
(preorder '())
. . cadr: contract violation
  expected: (cons/c any/c pair?)
  given: '()
> ;; ok seems like tree shouldn't be a null list in this assignment, I'll continue
(preorder simple)
'(#<procedure:+> 1 3)
> (inorder simple)
'(1 #<procedure:+> 3)
> (postorder simple)
'(1 3 #<procedure:+>)
> ;; seems correct
(preorder complex)
'(#<procedure:+>
  #<procedure:*>
  6
  3
  #<procedure:->
  5
  2)
> (inorder complex)
'(6
  #<procedure:*>
  3
  #<procedure:+>
  5
  #<procedure:->
  2)
> (postorder complex)
'(6
  3
  #<procedure:*>
  5
  2
  #<procedure:->
  #<procedure:+>)
> ;; I don't know why they are in column, but the order is correct
;; testing eval-tree
;; test evaluate simple, should be 4
(eval-tree simple)
4
> ;; test evaluate complex, should be 21
(eval-tree complex)
21
> ;; testing map-leaves
;; I'll use square as the function
square
#<procedure:square>
> (map-leaves square simple)
'(1 #<procedure:+> 9)
> (map-leaves cube complex)
'((216 #<procedure:*> 27)
  #<procedure:+>
  (125 #<procedure:-> 8))
> 