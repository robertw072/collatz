import java.util.*;

public class Collatz
{
	public static void main(final String[] args)
	{
		// using long for n, as it the largest integer data type available in java
        long n = 1;
		int count;
		long max_value = 5000000000;

		// I use a tuple class that is also included in the git repository, x is the number the collatz length is computed for,
		// y is the length of the collatz sequence
		// To compile -> javac Collatz.java Tuple.java
		
		// Create an array list to hold integer/length pairs
		final ArrayList<Tuple<Long, Integer>> collatzList = new ArrayList<Tuple<Long, Integer>>();

		// zero the list
		for (int i = 0; i < 10; i++)
		{
			collatzList.add(new Tuple<Long, Integer>((long) 0, 0));
		}

		for (int i = 0; i < max_value; i++)
		{
			Tuple<Long, Integer> tup = new Tuple<Long,Integer> (n, countCollatz(n));
			if (tup.y > collatzList.get(9).y)									// see if tup has a new max length
			{
				int offset = 0;
				while (tup.y < collatzList.get(offset).y)						// put it in its place in the list
				{
					offset = offset + 1;
				}

				int temp = offset;
				offset = 9;
				while (offset > temp)											// shift the other elements into proper place
				{
					collatzList.set(offset, collatzList.get(offset - 1));
					offset = offset - 1;
				}
				collatzList.set(temp, tup);										// store the tuple in a list
			}
			n = n + 1;
		}

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

	public static int countCollatz(long n)
	{
		int count = 0; // keeps track of the length of the collatz sequence
		
		// follow steps until n = 1
		while (n != 1)
		{
			// if odd
			if (n%2 == 1)
				n = 3*n + 1;
			else // if even
				n = n / 2;

			count++;
		}
		return count;
	}
}
