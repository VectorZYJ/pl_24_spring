;-------Problem 1 chain (lis v)-------

(define (chain lis v)
  (if (null? lis) v
      (chain (cdr lis) ((car lis) v)))
)

#|
(define (inc a) (+ a 1))
(define (dec a) (- a 1))
(chain (list inc dec inc dec) 5) 
(chain (list dec dec dec) 5)
(chain (list inc) 5)
(chain '() 2)
|#



;-------Problem 2 chain_odd (lis v)-------

(define (chain_odd lis v)
  (if (null? lis) v
      (chain_odd (cdr lis) (if (and (number? v) (odd? v)) ((car lis) v) v)))
)

#|
(define (inc n) (+ n 1))
(define (dec n) (- n 1))
(define (plus2 n) (+ n 2))
(define (minus2 n) (- n 2))
(define (ident s) s)
(chain_odd (list inc inc inc inc) 3)
(chain_odd (list plus2 plus2 dec minus2) 3)
(chain_odd '() 2)
(chain_odd (list ident ident) "hey")
|#



;-------Problem 3 zip (lis1 lis2)-------

(define (zip lis1 lis2)
  (if (null? lis1) '()
      (cons (list (car lis1) (car lis2)) (zip (cdr lis1) (cdr lis2))))
)

#|
(zip '(1 2 3) '(4 5 6))
(zip '(1 2) '(2 3))
|#



;-------Problem 4 unzip (lis)-------

(define (unzip lis)
  (if (null? lis) (list '() '())
      (let ((unzip_rest (unzip (cdr lis))))
        (list (cons (caar lis) (car unzip_rest))
              (cons (cadar lis) (cadr unzip_rest)))))
)

#|
(unzip '((1 4) (2 5) (3 6)))
(unzip '((1 2) (2 3)))
|#



;-------Problem 5 cancellist (lis1 lis2)-------

(define (cancellist lis1 lis2)
  (define (exist elem l) ; Check whether elem exists in l
    (if (null? l) #f
        (if (= (car l) elem) #t
            (exist elem (cdr l)))))
  (define (cancel l1 l2) ; Remove elements in l1 that exists in l2
    (if (null? l1) '()
      (if (exist (car l1) l2) (cancel (cdr l1) l2)
          (cons (car l1) (cancel (cdr l1) l2)))))
  (list (cancel lis1 lis2) (cancel lis2 lis1))
)

#|
(cancellist '() '())
(cancellist '(1 3) '(2 4))
(cancellist '(1 2) '(2 4))
(cancellist '(1 2 3) '(1 2 2 3 4))
|#



;-------Problem 6 reverse2 (lis)-------

(define (reverse2 lis)
  (define (helper lis reversed)
    (if (null? lis) reversed
        (helper (cdr lis) (cons (car lis) reversed))))
  (helper lis '())
)

#|
(reverse2 '(1 2 3))
|#



;-------Problem 7 interleave_outer (lis1 lis2)-------

(define (interleave_outer lis1 lis2)
  (define (reverse2 lis)
    (define (helper lis reversed)
      (if (null? lis) reversed
          (helper (cdr lis) (cons (car lis) reversed))))
  (helper lis '()))
  (define (merge lis1 lis2)
    (if (null? lis1) lis2
        (if (null? lis2) lis1
            (cons (car lis1) (cons (car lis2) (merge (cdr lis1) (cdr lis2)))))))
  (merge lis1 (reverse lis2))
)

#|
(interleave_outer '(1 2 3) '(a b c))
(interleave_outer '(1 2 3) '(a b c d e f))
(interleave_outer '(1 2 3 4 5 6) '(a b c))
|#



;--------Problem 8 count_occurrences (lis x)-------

(define (count_occurrences lis x)
  (if (null? lis) 0
      (+ (if (= (car lis) x) 1 0) (count_occurrences (cdr lis) x)))
)

#|
(count_occurrences '(1 2 3 2 4) 2)
(count_occurrences '(1 2 3 2 4) 1)
(count_occurrences '(1 2 3 2 4) 6)
|#
