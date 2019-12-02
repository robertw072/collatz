#!/usr/bin/julia

# recursive function to compute the collatz sequence length for given n
function count_collatz(n, count)
    if (n == 1)         # if n = 1, stop
        return count
    end

    if (n%2 == 1)       # if n is odd, do this
        n = 3*n + 1
        return count_collatz(n, count+1)
    else                # if n is even, do this
        n = n / 2
        return count_collatz(n, count+1)
    end
end

collatz_list = Array{Tuple{Int128, Int}}(undef, 0)

# compute the collatz sequence lengths of each number up to 5 billion
num = Int128(1)  
for i = 1:5000000000
    global num
    count = 0
    tup = (num, count_collatz(num, count))  # holds integer length pairs
    push!(collatz_list, tup)
    num = num + 1
end

# sort the list by length and print the 10 largest lengths
sort!(collatz_list, by = x->x[2], rev = true)
small = Array{Tuple{Int128, Int}}(undef, 0) # second array to make sorting 10 largest easier

println("The 10 largest collatz lengths sorted by length: ")
for i = 1:10
    println(collatz_list[i])
    push!(small, collatz_list[i])
end

# sort the list by magnitude of n and print 10 largest lengths
sort!(small, by = x->x[1], rev = true)

println("The 10 largest collatz lengths sorted by magnitude: ")
for i = 1:10
    println(small[i])
end




