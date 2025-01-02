#lang racket

;; Day 1: Historian Hysteria

(command-line #:args (filename)
(let* ([input (file->lines filename)]
       [l1 (map (λ (x) (string->number (substring x 0 5))) input)]
       [l2 (map (λ (x) (string->number (substring x 8 13))) input)])

(foldl
  (λ (a b acc) (+ acc (abs (- a b))))
  0 (sort l1 <) (sort l2 <))

(foldl
  (λ (a acc) (+ acc (* a (count (λ (x) (= x a)) l2))))
  0 l1)))
