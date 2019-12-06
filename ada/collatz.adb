with Ada.Text_IO; 
use Ada.Containers;

procedure Collatz is 
type Tuple is record
    Num     : Long_Integer;
    Length  : Integer;
end record;

    n   : Long_Integer;
    max_value       : Long_Integer;
    collatz_list    : array(1..10) of Tuple;
    tup : Tuple;
    lsup : Integer;
    bubble  : Integer;
    tmp : Tuple;
    offset  : Integer;
    temp    : Integer;

    -- Function to compute the collatz sequence length for a given integer
    function CountCollatz (intIn: Long_Integer) return Integer is
    N     : Long_Integer := intIn; -- in parameter cannot be manipulated, so we change it locally
    count : Integer := 0;          -- count to track length of the collatz sequence 
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
    max_value := 5000000000;
    --Ada.Text_IO.Put_Line(Integer'Image(CountCollatz(n)));
    for i in Integer range 1..10 loop
        tmp.Num := 0;
        tmp.Length := 0;
        collatz_list(i) := tmp;
    end loop;

    for i in Long_Integer range 1..max_value loop    -- compute collatz sequence lengths for all n < 5 billion
        tup.Num := n;
        tup.Length := CountCollatz(n);
        -- check if the new length is a maximum
        if (tup.Length > collatz_list(10).Length) then 
            offset := 1;
            -- determine where to put the new max
            while (tup.Length < collatz_list(offset).Length) loop
                offset := offset + 1;
            end loop;

            temp := offset;
            offset := 10;
            -- shift everything else 
            while (offset > temp) loop
                collatz_list(offset) := collatz_list(offset - 1);
                offset := offset - 1;
            end loop;
            collatz_list(temp) := tup;  --store the new max in the list
        end if;
        n := n + 1;
    end loop;

    Ada.Text_IO.Put_Line("The 10 largest collatz lengths sorted by length: ");
    for j in Integer range 1..10 loop   -- print 10 largest collatz sequenc lengths sorted by length
        Ada.Text_IO.Put(Long_Integer'Image(collatz_list(j).Num));
        Ada.Text_IO.Put(" ");
        Ada.Text_IO.Put(Integer'Image(collatz_list(j).Length));
        Ada.Text_IO.New_Line;
        collatz_list(j) := collatz_list(j);
    end loop;

    -- now sort the 10 largest collatz link by the magnitude of n, bubblesort
    lsup := 10;
    while lsup > 1 loop
        bubble := 0;
        for i in Integer range 1..(lsup-1) loop
            if collatz_list(i).Num < collatz_list(i+1).Num then
                tmp := collatz_list(i);
                collatz_list(i) := collatz_list(i+1);
                collatz_list(i+1) := tmp;
                bubble := i;
            end if;
        end loop;
        lsup := bubble;
    end loop;

    Ada.Text_IO.Put_Line("The 10 largest collatz lengths sorted by magnitude: ");
    for j in Integer range 1..10 loop   -- print 10 largest collatz sequenc lengths sorted by magnitude of n
        Ada.Text_IO.Put(Long_Integer'Image(collatz_list(j).Num));
        Ada.Text_IO.Put(" ");
        Ada.Text_IO.Put(Integer'Image(collatz_list(j).Length));
        Ada.Text_IO.New_Line;
    end loop;

end Collatz;

