#!/usr/bin/julia

function count_collatz(n)
    count = 0
    while n != 1
        if (n%2 == 1)
            n = 3*n + 1
        else
            n = n / 2
        end
        count = count + 1
    end 
    return count
end

# this program holds the number for which the collatz sequence length is to be computed,
# an Int128 called "num" and its corresponding sequence length, and Int in a tuple.
# Int128 is used for "num" as it's the largest integer data type in julia. 

collatz_list = Array{Tuple{Int128, Int}}(undef, 0)
# zero the list
for i = 1:10
    tup1 = (Int128(0), 0)
    push!(collatz_list, tup1)
end

# compute the collatz sequence lengths of each number up to 5 billion
num = Int128(1)                                     # number to compute collatz length of
max_value = Int128(10000)  
for i = 1:max_value
    global num
    tup = (num, count_collatz(num))
    if (tup[2] > collatz_list[10][2])               # determine if tup has a new max length to add
        offset = 1
        while (tup[2] < collatz_list[offset][2])    # determine where tup should go in array
            offset = offset + 1
        end

        temp = offset
        offset = 10
        while (offset > temp)                       # shift the other elements
            collatz_list[offset] = collatz_list[offset - 1]
            offset = offset - 1
        end
        collatz_list[temp] = tup                    # store tup in the array
    end
    num = num + 1
end

# print the collatz lengths sorted by length
println("The 10 largest collatz lengths sorted by length: ")
for i = 1:10
    println(collatz_list[i])
end

# sort the list by magnitude of num
sort!(collatz_list, by = x->x[1], rev = true)

# print the collatz lengths sorted by magnitude
println("The 10 largest collatz lengths sorted by magnitude: ")
for i = 1:10
    println(collatz_list[i])
end




