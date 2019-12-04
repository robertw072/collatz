#!/usr/bin/sbcl --script

(defun count_collatz(n count_)
    (if (= n 1)
        (return-from count_collatz count_)
    )

    (if (= (mod n 2) 1)
        (setq n (+ (* 3 n) 1))    ; if odd do this
        (setq n (/ n 2))          ; else, do this
    )
    
    (count_collatz n (+ count_ 1))  ; recursive bit
)

(defvar count_ 0)
(defvar n 97)
(write (count_collatz n count_))
(terpri)