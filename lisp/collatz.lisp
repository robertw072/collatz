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
(write (count_collatz n count_))
(terpri)

