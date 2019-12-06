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

collatz_list = Array.new    # array to store integer/length pairs
for i in 0..9               # zero the array, used to sort initial time
  tup1 = Tuple.new
  tup1.num = 0
  tup1.length = 0
  collatz_list[i] = tup1
end 

n = 1                       # holds value to be computed
max_value = 5000000000      # numbers to compute collatz sequence length

# this loop determines 10 max lengths and orders them by descending length
for i in 0..max_value-1
    count = 0
    tup = Tuple.new
    tup.num = n                                         # holds number to compute
    tup.length = count_collatz(n, count)                       # compute collatz sequence length
    if (tup.length > collatz_list[9].length)
      offset = 0
      while (tup.length < collatz_list[offset].length)  # check if tup.length is new max
        offset = offset + 1
      end

      temp = offset
      offset = 9
      while (offset > temp)                             # shift other values in array
        collatz_list[offset] = collatz_list[offset - 1]
        offset = offset - 1
      end
      collatz_list[temp] = tup                          # store the tup in the array
    end
    n = n + 1
end

puts "The 10 longest collatz sequence lengths sorted by length: "
small = Array.new
for i in 0..9
    puts collatz_list[i]
end

sort_magnitude(small)   # sort the list by magnitude of the integer

puts "The 10 longest collatz sequence lengths sorted by magnitude: "
for i in 0..9
    puts collatz_list[i]
end