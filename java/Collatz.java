import java.util.*;

public class Collatz
{
	public static void main(final String[] args)
	{
		// using long for n, as it the largest integer data type available in java
		long n = 1;

		//Tuple<Long, Integer> tup = new Tuple<Long, Integer>(n, countCollatz(n));
		// Create an array list to hold integer/length pairs
		final ArrayList<Tuple<Long, Integer>> collatzList = new ArrayList<Tuple<Long, Integer>>();

		while (n != 5000000000L)
		{
			collatzList.add(new Tuple<Long, Integer>(n, countCollatz(n)));
			n++;
		}

		// comparator to sort the list by length of collatz sequence
		final Comparator<Tuple<Long, Integer>> comparator = new Comparator<Tuple<Long, Integer>>()
		{
			public int compare(final Tuple<Long, Integer> tupleA, final Tuple<Long, Integer> tupleB)
			{
				return tupleB.y.compareTo(tupleA.y);
			}
		};

		Collections.sort(collatzList, comparator);	// sorting list by length using comparator

		final ArrayList<Tuple<Long, Integer>> small = new ArrayList<Tuple<Long, Integer>>();
		System.out.println("The largest collatz sequence lengths sorted by length: ");
		for (int i = 0; i < 10; i++)
		{
			small.add(collatzList.get(i));
			System.out.println(small.get(i));
		}

		// comparator to sort the list by length of collatz sequence
		final Comparator<Tuple<Long, Integer>> comparator1 = new Comparator<Tuple<Long, Integer>>()
		{
			public int compare(final Tuple<Long, Integer> tupleA, final Tuple<Long, Integer> tupleB)
			{
				return tupleB.x.compareTo(tupleA.x);
			}
		};

		Collections.sort(small, comparator1);

		System.out.println("The largest collatz sequence lengths sorted by magnitude: ");
		for (int i = 0; i < 10; i++)
		{
			System.out.println(small.get(i));
		}

	}

	public static int countCollatz(long n)
	{
		int count = 1; // keeps track of the length of the collatz sequence
			       // starts at 1 since the 1 at the end of the sequence won't be counted
		
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
