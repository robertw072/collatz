#!/usr/bin/ruby -w

Tuple = Struct.new(:num, :length)   # struct to hold integer/length pairs

def count_collatz(n)    # function to compute the collatz length for a given n
    count = 1
    while n != 1 do
        if n%2 == 1 then    # if odd
            n = 3*n + 1
        else                # if even
            n = n / 2
        end
        count = count + 1
    end
    return count
end 

def sort_length(array)
    n = array.length
    loop do
      swapped = false
  
      (n-1).times do |i|
        if array[i].length < array[i+1].length
          array[i], array[i+1] = array[i+1], array[i]
          swapped = true
        end
      end
  
      break if not swapped
    end
  
    array
end

def sort_magnitude(array)
    n = array.length
    loop do
      swapped = false
  
      (n-1).times do |i|
        if array[i].num < array[i+1].num
          array[i], array[i+1] = array[i+1], array[i]
          swapped = true
        end
      end
  
      break if not swapped
    end
  
    array
end

n = 1                       # holds value to be computed
collatz_list = Array.new    # array to store integer/length pairs

for i in 0..5000000000-1
    tup = Tuple.new
    tup.num = n
    tup.length = count_collatz(n)
    collatz_list[i] = tup
    n = n + 1
end

sort_length(collatz_list)

puts "The 10 longest collatz sequence lengths sorted by length: "
small = Array.new
for i in 0..9
    puts collatz_list[i]
    small[i] = collatz_list[i]
end

sort_magnitude(small)

puts "The 10 longest collatz sequence lengths sorted by magnitude: "
for i in 0..9
    puts small[i]
end