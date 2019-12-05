using System;
using System.Collections.Generic;

namespace Collatz
{
	public static class CollatzMethods
	{
		// method to get the length of the collatz sequence for a given number
		public static int CountCollatz(ulong n)
		{
			int count = 1;	// keeps track of the collatz sequence length

			while (n != 1)
			{
				if (n%2 == 1)	// if odd
					n = 3*n + 1;
				else		// if even
					n = n / 2;
		
				count++;
			}
			return count;
		}
	}

	class Program
	{
		static void Main(string[] args)
		{
			ulong n = 1; // ulong is the largest integer data type, so we will store the n values as a ulong
			ulong max_val = 5000000000;
			Tuple<ulong, int>[] collatzList = new Tuple<ulong, int>[10];	// array to hold (n, length) pairs
			
			// zero the cube
			for (int j = 0; j < 10; j++)
				collatzList[j] = new Tuple<ulong, int>((ulong) 0, 0);

			ulong i = 0;
			while (i < max_val)
			{
				Tuple<ulong, int> tup = new Tuple<ulong, int> (n, CollatzMethods.CountCollatz(n));
				if (tup.Item2 > collatzList[9].Item2) // check if the length is a new max
				{
					int offset = 0;
					while(tup.Item2 < collatzList[offset].Item2) // find where to store new max
					{
						offset = offset + 1;
					}

					int temp = offset;
					offset = 9;
					while (offset > temp) // shift the other values in the array right
					{
						collatzList[offset] = collatzList[offset - 1];
						offset = offset - 1;
					}
					collatzList[temp] = tup;
				}
				n++;
				i++;
			}

			// sort the list by length
			Console.WriteLine("The list the longest Collatz sequences sorted by list length: ");
			for (int j = 0; j < 10; j++)
			{
				Console.WriteLine(collatzList[j]);
			} 

		}
	}
}
