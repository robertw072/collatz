#include <bits/stdc++.h>
#include <vector>

using namespace std;

// recursive function to compute length of collatz sequence 
// for given n
int countCollatz(unsigned long long int n, int count)
{
    if (n == 1)
    {
        return count;
    }
    if (n%2 == 1)
    {
        n = 3*n + 1;
        return countCollatz(n, count+1);
    }
    else
    {
        n = n / 2;
        return countCollatz(n, count+1);
    }
}

// function to sort list by magnitude of the interger passed to count collatz
bool sortByMagnitude(const tuple<unsigned long long int, int>& a,
		     const tuple<unsigned long long int, int>& b)
{
	return (get<0>(a) > get<0>(b));
} 

int main()
{
	// using unsigned long long int for n, as it is the largest integer 
	// data type available in c++
	
	// array to hold the integer being evaluated and its collatz sequence length
	tuple<unsigned long long int, int> collatzList[10];

	// zero the array
	for (int i = 0; i < 10; i++)
	{
		collatzList[i] = make_tuple(0, 0);
	}

	unsigned long long int n = 1;
	unsigned long long int max_value = 5e9;
	unsigned long long int i = 0;
	
	while (i < max_value)
	{
		// this loop stores the inegers and collatz sequence lengths in an array
		int count = 0;
		tuple<unsigned long long int, int> tup = make_tuple(n, countCollatz(n, count)); // compute length of collatz sequence and store as a tuple
		if (get<1>(tup) > get<1>(collatzList[10]))	// check if new length is a max
		{
			int offset = 0;
			// determine where new max should go in list
			while (get<1>(tup) < get<1>(collatzList[offset]))
			{
				offset = offset + 1;
			}

			int temp = offset;
			offset = 10;
			// adjust other values of list 
			while (offset > temp)
			{
				collatzList[offset] = collatzList[offset - 1];
				offset = offset - 1;
			}
			collatzList[temp] = tup;
		}
		n++;	//increment n
		i++;	// increment i
	}

	// print the 10 largest collatz sequences lengths sorted by length
	cout << "The 10 largest collatz sequence lengths sorted by length: " << endl;
	for (int j = 0; j < 10; j++)
	{
		cout << get<0>(collatzList[j]) << " " << get<1>(collatzList[j]) << endl;
	}

	// print the integers ordered by the magnitude of the integers, descending
	
	// sort the list by magnitude
	sort(begin(collatzList), end(collatzList), sortByMagnitude);

	cout << "The integers giving the longest Collatz Sequence length, ordered by magnitude: " << endl;
	for (int j = 0; j < 10; j++)
	{
		cout << get<0>(collatzList[j]) << " " << get<1>(collatzList[j]) << endl;
	}

	return 0;
}
