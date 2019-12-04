#!/usr/bin/perl
use warnings; no warnings 'recursion';

sub CountCollatz
{
    my $n = $_[0];
    my $count = $_[1];

    if ($n == 1)
    {
        return $count;
    }
    if ($n%2 == 1)
    {
        $n = 3*$n + 1;
        return CountCollatz($n, $count + 1);
    }
    else 
    {
        $n = $n / 2;
        return CountCollatz($n, $count + 1);
    }
}

$count = 0;
$n = 97;
print CountCollatz($n, $count), "\n";