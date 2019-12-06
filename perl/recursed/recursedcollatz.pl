#!/usr/bin/perl
use warnings; no warnings 'recursion';

sub CountCollatz
{
    my $n = $_[0];                              # input $n, number to compute collatz sequence of
    my $count = $_[1];                          # output $count, length of collatz seq

    if ($n == 1)                                # if n = 1, stop
    {
        return $count;
    }
    if ($n%2 == 1)                              # if odd
    {
        $n = 3*$n + 1;
        return CountCollatz($n, $count + 1);    # recur
    }
    else                                        # if even
    {
        $n = $n / 2;
        return CountCollatz($n, $count + 1);    # recur
    }
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
    $counter = 0;                                   # tracks collatz sequence length
    $result = CountCollatz($n, $counter);           # compute collatz length of $n
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