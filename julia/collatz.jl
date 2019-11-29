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

collatz_list = Array{Tuple{Int128, Int}}(undef, 0)

# compute the collatz sequence lengths of each number up to 5 billion
num = Int128(1)  
for i = 1:10000
    global num
    tup = (num, count_collatz(num))
    push!(collatz_list, tup)
    num = num + 1
end

# sort the list by length and print the 10 largest lengths
sort!(collatz_list, by = x->x[2], rev = true)
small = Array{Tuple{Int128, Int}}(undef, 0)

println("The 10 largest collatz lengths sorted by length: ")
for i = 1:10
    println(collatz_list[i])
    push!(small, collatz_list[i])
end

sort!(small, by = x->x[1], rev = true)

println("The 10 largest collatz lengths sorted by magnitude: ")
for i = 1:10
    println(small[i])
end




