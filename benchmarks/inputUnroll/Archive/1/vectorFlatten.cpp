
#include <bits/stdc++.h>
using namespace std;

class FlattenVector {
public:
	int n;
	vector<vector<int>::iterator> iStart;
	vector<vector<int>::iterator> iEnd;
	int currIndex;
	// Store ending and starting iterators.
	FlattenVector(vector<vector<int> >& v)
	{

		n = v.size();
		currIndex = 0;
		iStart.resize(n);
		iEnd.resize(n);
		for (int i = 0; i < n; i++) {
			iStart[i] = v[i].begin();
			iEnd[i] = v[i].end();
		}
	}
	// Returns true if any element is left.
	bool hasNext()
	{
		for (int i = 0; i < n; i++) {
			if (iStart[i] != iEnd[i])
				return true;
		}
		return false;
	}

	int next()
	{
		// Vector at currIndex is printed,
		// increment currIndex.
		if (iStart[currIndex]
			== iEnd[currIndex]) {
			currIndex++;
			return next();
		}
		// Increment iterator
		// and return the value.
		else
			return *iStart[currIndex]++;
	}
};


// int main()
// {
// 	vector<vector<int> >
// 		v{ { 1, 2 },
// 		{ 3 ,5,7},
// 		{ 4, 5, 6 },
// 		{ 7, 8, 9, 10 } };
		
// 	FlattenVector iter(v);

// 	while (iter.hasNext())
// 		cout << iter.next() << " ";
// 	return 0;

// }

