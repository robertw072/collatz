with Ada.Text_IO;
with Ada.Containers.Vectors; 
use Ada.Containers;

procedure Collatz is 
type Tuple is record
    Num     : Integer;
    Length  : Integer;
end record;

    n   : Integer;
    collatz_list    : array(1..10000) of Tuple;
    small           : array(1..10) of Tuple;
    tup : Tuple;
    i   : Integer;
    j   : Integer;
    lsup : Integer;
    bubble  : Integer;
    tmp : Tuple;

    -- Function to compute the collatz sequence length for a given integer
    function CountCollatz (intIn: Integer) return Integer is
    N     : Integer := intIn; -- in parameter cannot be manipulated, so we change it locally
    count : Integer := 0;     -- count to track length of the collatz sequence 
begin
    while N /= 1 loop         -- loop until N = 1, termination condition
        if N mod 2 = 1 then   -- if odd
            N := 3*N + 1;
        else                  -- if even
            N := N / 2;
        end if;
        count := count + 1;   -- increment count
    end loop;
    return count;             -- return the length of the collatz sequence
end CountCollatz;

begin 
    n := 1;
    --Ada.Text_IO.Put_Line(Integer'Image(CountCollatz(n)));

    for i in Integer range 1..10000 loop    -- compute collatz sequence lengths for all n < 5 billion
        tup.Num := n;
        tup.Length := CountCollatz(n);
        collatz_list(i) := tup;             -- store integer/length paris in array
        n := n + 1;
    end loop;

    -- sort array by largest collatz sequence lengths, descending
    lsup := 10000;
    while lsup > 1 loop
        bubble := 0;
        for i in Integer range 1..(lsup-1) loop
            if collatz_list(i).Length < collatz_list(i+1).Length then
                tmp := collatz_list(i);
                collatz_list(i) := collatz_list(i+1);
                collatz_list(i+1) := tmp;
                bubble := i;
            end if;
        end loop;
        lsup := bubble;
    end loop;

    Ada.Text_IO.Put_Line("The 10 largest collatz lengths sorted by length: ");
    for j in Integer range 1..10 loop   -- print 10 largest collatz sequenc lengths sorted by length
        Ada.Text_IO.Put(Integer'Image(collatz_list(j).Num));
        Ada.Text_IO.Put(" ");
        Ada.Text_IO.Put(Integer'Image(collatz_list(j).Length));
        Ada.Text_IO.New_Line;
        small(j) := collatz_list(j);
    end loop;

    -- now sort the 10 largest collatz link by the magnitude of n
    lsup := 10;
    while lsup > 1 loop
        bubble := 0;
        for i in Integer range 1..(lsup-1) loop
            if small(i).Num < small(i+1).Num then
                tmp := small(i);
                small(i) := small(i+1);
                small(i+1) := tmp;
                bubble := i;
            end if;
        end loop;
        lsup := bubble;
    end loop;

    Ada.Text_IO.Put_Line("The 10 largest collatz lengths sorted by magnitude: ");
    for j in Integer range 1..10 loop   -- print 10 largest collatz sequenc lengths sorted by magnitude of n
        Ada.Text_IO.Put(Integer'Image(small(j).Num));
        Ada.Text_IO.Put(" ");
        Ada.Text_IO.Put(Integer'Image(small(j).Length));
        Ada.Text_IO.New_Line;
    end loop;

end Collatz;

