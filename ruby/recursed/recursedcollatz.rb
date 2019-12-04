#!/usr/bin/ruby -w

Tuple = Struct.new(:num, :length)   # struct to hold integer/length pairs

def count_collatz(n, count)    # recursive function to compute the collatz length for a given n
    if n == 1 then             # if n is at 1, stop
        return count
    end
    if n%2 == 1 then           # if odd do this
        n = 3*n + 1
        return count_collatz(n, count+1)
    else                       # if even do this
        n = n / 2
        return count_collatz(n, count+1)
    end
end 

def sort_length(array)  # bubblesort to sort by length
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

def sort_magnitude(array)   # bubble sort for sorting by magnitude
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
count = 0                   # count is the length of collatz sequence
collatz_list = Array.new    # array to store integer/length pairs

for i in 0..5000000000-1
    tup = Tuple.new
    tup.num = n
    tup.length = count_collatz(n, count)
    collatz_list[i] = tup
    n = n + 1
    count = 0;              # reset count for next call to count_collatz
end

sort_length(collatz_list)   # sort by length

puts "The 10 longest collatz sequence lengths sorted by length: "
small = Array.new
for i in 0..9
    puts collatz_list[i]
    small[i] = collatz_list[i]
end

sort_magnitude(small)       #sort by magnitude

puts "The 10 longest collatz sequence lengths sorted by magnitude: "
for i in 0..9
    puts small[i]
end