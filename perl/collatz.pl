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


