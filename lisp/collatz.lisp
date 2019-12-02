#!/usr/bin/sbcl --script

; function to compute the collatz sequence length of a given n
(defun count_collatz(n count_)
    (loop while (/= n 1) do           ; if n = 1, stop
        (if (= (mod n 2) 1)         
            (setq n (+ (* 3 n) 1))    ; if odd do this
            (setq n (/ n 2))          ; else, do this
        )
        (setq count_ (+ count_ 1))    ; lisp returns the last statement evaluated, so count
    )
    (return-from count_collatz count_)
)

(defvar count_ 0)
(defvar n 1)
;(write (count_collatz n count_))
;(terpri)

(setq collatz_list(make-array 5000000000 :fill-pointer 0))   ; create a vector to hold integer/length pairs

(defvar tuple)  ; variable to hold integer/length pairs
(loop while (< n 5000000000) do
    (setq tuple (cons n (count_collatz n count_)))  ; store the integer/length pairs
    (vector-push tuple collatz_list)                ; add the tuple to the vector
    (setq n (+ n 1))
    (setq count_ 0)                                 ; reset count to zero for the next function call
)

(write collatz_list)
(terpri)