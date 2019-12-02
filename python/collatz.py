#!/usr/bin/python

def countCollatz(n):
    count = 1        # starts at 1 since the 1 at the end of the sequence won't be counted
    while (n != 1):
        if (n%2 == 1):
            n = 3*n + 1
        else: 
            n = n / 2
        count = count + 1

    return count

collatzList = []    # declare the list to hold the integer/length pairs of the sequence
n = 1               # value to compute the length of the collatz sequence for
for i in range(5000000000):
    tup1 = (n, countCollatz(n))  # integer/length pair
    collatzList.append(tup1)
    n = n + 1                   # increment the integer to be computed
    
collatzList.sort(key=lambda tup: tup[1], reverse=True)  # sort the list by length of collatz sequence

small = []          # declare the list to hold the 10 largest collatz lengths

print("The 10 longest Collatz Sequence lengths sorted by length: ")
for i in range (9): # print the list of the 10 largest collatz seqences
    print(collatzList[i])
    small.append(collatzList[i])                        # store the 10 largest collatz sequence lengths to easily sort by magnitude

small.sort(key= lambda tup: tup[0], reverse=True)       # sort by magnitude

print("The 10 longest Collatz Sequence lengths sorted by magnitude: ")
for i in range (9):
    print(small[i])