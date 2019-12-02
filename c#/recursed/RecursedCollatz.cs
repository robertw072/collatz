using System;
using System.Collections.Generic;

namespace RecursedCollatz
{
	public static class CollatzMethods
	{
		// method to get the length of the collatz sequence for a given number
		public static int CountCollatz(ulong n, int count)
		{
			if (n == 1)
                return count;
            if (n%2 == 1)
            {
                n = 3*n + 1;
                return CountCollatz(n, count+1);
            }
            else
            {
                n = n / 2;
                return CountCollatz(n, count+1);
            }
		}
	}

	class Program
	{
		static void Main(string[] args)
		{
			ulong n = 1; // ulong is the largest integer data type, so we will store the n values as a ulong
            int count;

			List<Tuple<ulong, int>> collatzList = new List<Tuple<ulong, int>>();	// list to hold (n, length) pairs

			while (n < 5000000000)
			{
                count = 0;
				collatzList.Add(new Tuple<ulong, int>(n, CollatzMethods.CountCollatz(n, count))); // store tuples in list
				n++;
			}

			List<Tuple<ulong, int>> small = new List<Tuple<ulong, int>>(); // this list holds the largest collatz sizes
			// now we sort the list by length of collatz sequence and print it
			collatzList.Sort((t1, t2) => t2.Item2.CompareTo(t1.Item2));	

			Console.WriteLine("The list the longest Collatz sequences sorted by list length: ");
			for (int i = 0; i < 10; i++)
			{
				Console.WriteLine(collatzList[i]);
				small.Add(collatzList[i]); // store the values in the new list to sort later
			} 

			// sort list by magnitude of integers and print
			small.Sort((t1, t2) => t2.Item1.CompareTo(t1.Item1));

			Console.WriteLine("The list the longest Collatz sequences sorted by magnitude: ");
			for (int i = 0; i < 10; i++)
			{
				Console.WriteLine(small[i]);
			} 

		}
	}
}