import java.util.*;

public class RecursedCollatz
{
	public static void main(final String[] args)
	{
		// using long for n, as it the largest integer data type available in java
        long n = 1;
		int count;
		long max_value = 5000000000;

		//Tuple<Long, Integer> tup = new Tuple<Long, Integer>(n, countCollatz(n));
		// Create an array list to hold integer/length pairs
		final ArrayList<Tuple<Long, Integer>> collatzList = new ArrayList<Tuple<Long, Integer>>();

		// zero the list
		for (int i = 0; i < 10; i++)
		{
			collatzList.add(new Tuple<Long, Integer>((long) 0, 0));
		}

		for (int i = 0; i < max_value; i++)
		{
			count = 0;
			Tuple<Long, Integer> tup = new Tuple<Long,Integer> (n, countCollatz(n, count));
			if (tup.y > collatzList.get(9).y)
			{
				int offset = 0;
				while (tup.y < collatzList.get(offset).y)
				{
					offset = offset + 1;
				}

				int temp = offset;
				offset = 9;
				while (offset > temp)
				{
					collatzList.set(offset, collatzList.get(offset - 1));
					offset = offset - 1;
				}
				collatzList.set(temp, tup);
			}
			n = n + 1;
		}

		// print the 10 largest collatz numbers sorted by length
		System.out.println("The largest collatz sequence lengths sorted by length: ");
		for (int i = 0; i < 10; i++)
		{
			System.out.println(collatzList.get(i));
		}

		// comparator to sort the list by magnitude of n
		final Comparator<Tuple<Long, Integer>> comparator1 = new Comparator<Tuple<Long, Integer>>()
		{
			public int compare(final Tuple<Long, Integer> tupleA, final Tuple<Long, Integer> tupleB)
			{
				return tupleB.x.compareTo(tupleA.x);
			}
		};

		Collections.sort(collatzList, comparator1);

		System.out.println("The largest collatz sequence lengths sorted by magnitude: ");
		for (int i = 0; i < 10; i++)
		{
			System.out.println(collatzList.get(i));
		}

	}

	// recursive function to compute the collatz sequence length of n
	public static int countCollatz(long n, int count)
	{	
        if (n == 1)								// if n = 1, stop
            return count;						
        if (n%2 == 1)							// if n is odd
        {
            n = 3*n + 1;
            return countCollatz(n, count+1);	// recur
        }
        else 									// else n is even
        {
            n = n / 2;
            return countCollatz(n, count+1);	// recur
        }
	}
}
