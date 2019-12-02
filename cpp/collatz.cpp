#include <bits/stdc++.h>
#include <vector>

using namespace std;

int countCollatz(unsigned long long int n)
{
	int count = 1; // keeps track of number of numbers in collatz sequence
				 // starts at 1 since the 1 at the end of the sequence will not be counted

	// Follow steps until n = 1
	while (n != 1)
	{
		// if odd
		if (n & 1)
			n = 3*n + 1;

		// if even
		else 
			n = n / 2;

		count++;	
	}
	return count;
}

// Function to sort the vector of tuples by length of collatz sequence in descending order
bool sortByLength(const tuple<unsigned long long int, int>& a,
		  const tuple<unsigned long long int, int>& b)
{
	return (get<1>(a) > get<1>(b));
}

bool sortByMagnitude(const tuple<unsigned long long int, int>& a,
		     const tuple<unsigned long long int, int>& b)
{
	return (get<0>(a) > get<0>(b));
} 

int main()
{
	// using unsigned long long int for n, as it is the largest integer 
	// data type available in c++
	
	// vector to hold the integer being evaluated and its collatz sequence length
	vector<tuple<unsigned long long int, int> > collatzList;

	unsigned long long int n = 1;

	while (n < 5000000000)
	{
		// this loop stores the inegers and collatz sequence lengths in an array
		collatzList.push_back(make_tuple(n, countCollatz(n)));
		n++;
	}

	// sort the whole list by length of collatz sequence
	sort(collatzList.begin(), collatzList.end(), sortByLength);

	// print the integers ordered by the length of collatz sequence, descending	

	cout << "The integers giving the longest Collatz Sequence length, ordered by length: " << endl;
	vector<tuple<unsigned long long int, int> > small;
	for (int i = 0; i < 10; i++)
	{
		small.push_back(make_tuple(get<0>(collatzList[i]), get<1>(collatzList[i])));
		cout << get<0>(small[i]) << " " << get<1>(small[i]) << endl;
	}

	// print the integers ordered by the magnitude of the integers, descending
	
	sort(small.begin(), small.end(), sortByMagnitude);
	cout << "The integers giving the longest Collatz Sequence length, ordered by magnitude: " << endl;
	for (int i = 0; i < 10; i++)
	{
		cout << get<0>(small[i]) << " " << get<1>(small[i]) << endl;
	}

	return 0;
}
