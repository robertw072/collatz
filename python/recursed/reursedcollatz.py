#!/usr/bin/python

# recurive funtcion to compute collatz sequence length of a given n
def countCollatz(n, count):
    if (n == 1):            # if n is 1, stop
        return count
    if (n%2 == 1):          # if n is odd, do this
        n = 3*n + 1
        return countCollatz(n, count+1)
    else:                   # if n is even, do this
        n = n / 2
        return countCollatz(n, count+1)

collatzList = []    # declare the list to hold the integer/length pairs of the sequence
n = 1               # value to compute the length of the collatz sequence for
for i in range(5000000000):
    count = 0                   # count reset for each recursive function call
    tup1 = (n, countCollatz(n, count))  # integer/length pair
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