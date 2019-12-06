#!/usr/bin/perl
use warnings;

# function that returns the length of the collatz sequence of given n
sub CountCollatz      
{
    my $n = $_[0];    # special array holds function arguments in perl, this accesses the one element passed and puts it in n
    my $count = 0;

    while ($n != 1)
    {
        if ($n%2 == 1)  # if odd
        {
            $n = 3*$n + 1;
        }
        else            # if even
        {
            $n = $n / 2;
        }
        $count = $count + 1;
    }
    return $count;
}

# now we'll start our main...

# we will use parallel arrays nums and lengths to hold the value for which the collatz
# sequence length should be computed for and the collatz length, respectively
for ($i = 0; $i < 10; $i = $i + 1)
{
    $nums[$i] = 0;       # zero the arrays
    $vals[$i] = 0;
}

$max_value = 5000000000;
$n = 1;

for ($j = 0; $j < $max_value; $j = $j + 1)
{
    $result = CountCollatz($n);                     # compute collatz length of $n
    if ($result > $vals[9])                         # check if it is a new max
    {
        $offset = 0;
        while ($result < $vals[$offset])            # find where it should go in the list
        {
            $offset = $offset + 1;
        }

        $temp = $offset;
        $offset = 9;
        while ($offset > $temp)                     # shift the rest of the values back into place
        {
            $nums[$offset] = $nums[$offset - 1];
            $vals[$offset] = $vals[$offset - 1];
            $offset = $offset - 1;
        }
        $nums[$temp] = $n;                          # store $n and collatz length in nums
        $vals[$temp] = $result;                     # and vals
    }
    $n = $n + 1;                                    # increment $n
}

# print the things in order of collat sequence length
print"The 10 integers with the largest collatz sequence lengths are: \n";
for ($k = 0; $k < 10; $k = $k + 1)
{
    print"$nums[$k]  $vals[$k]\n";
}