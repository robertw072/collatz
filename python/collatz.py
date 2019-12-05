#!/usr/bin/python

def countCollatz(n):
    count = 0        # starts at 1 since the 1 at the end of the sequence won't be counted
    while (n != 1):
        if (n%2 == 1):
            n = 3*n + 1
        else: 
            n = n / 2
        count = count + 1

    return count

num = []    # parallel arrays used to hold integer n and the collatz sequence length
length = []
# zero the list
for i in range(10):
    num.append(0)
    length.append(0)

n = 1               # value to compute the length of the collatz sequence for
max_value = 5000000000   # collatz values to compute length of
for i in xrange(max_value):
    result = countCollatz(n)    # length of collatz sequence for n
    if (result > length[9]):    # determine if result is a max
        offset = 0
        while (result < length[offset]):    # determine where result should go
            offset = offset + 1

        # adjust the positions of the other values in lists
        temp = offset
        offset = 9
        while (offset > temp):
            num[offset] = num[offset - 1]
            length[offset] = length[offset - 1]
            offset = offset - 1
        # put numbers in list
        num[temp] = n
        length[temp] = result    
    n = n + 1                   # increment the integer to be computed

# print the list
print("The 10 longest Collatz Sequence lengths sorted by length: ")
for i in range (9): # print the list of the 10 largest collatz seqences
    print("n: %s length: %s" % (num[i], length[i]))