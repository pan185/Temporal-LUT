// #include "vectorFlatten.cpp"
// #include "txt2Vector.cpp"


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
#include <iostream>
#include <string>
#include <fstream>
#include <vector>
#include <bits/stdc++.h>
using namespace std;

std::vector<std::vector<double>> get_matrix(std::string file_path, char sep)
{
	std::vector<std::vector<double>> mat;
	std::ifstream file;
	file.open(file_path);
	// Throw exception if you want to
	if(!file.is_open())
	{
		return mat;
	}
	while(!file.eof())
	{
		std::string row;
		std::getline(file, row);
		std::vector<double> row_vec;
		std::string row_value = "";
		for(char c : row)
		{
			// If the character is seperator
			if(c == sep)
			{
				// Convert the string to double and append it and reset the string
				row_vec.push_back(std::stod(row_value));
				row_value = "";
			}
			else
			{
				row_value += c;
			}
		}
		// If the string is not empty append the last value [Last value generally gets ignored as there is no seperator afterwards]
		if(row_value.size() != 0)
		{
			row_vec.push_back(std::stod(row_value));
			row_value = "";
		}
		// Append the row now
		mat.push_back(row_vec);
	}
	file.close(); // Always close the opened file
	return mat;
}

class FlattenVector {
public:
	int n;
	vector<vector<double>::iterator> iStart;
	vector<vector<double>::iterator> iEnd;
	int currIndex;
	// Store ending and starting iterators.
	FlattenVector(vector<vector<double> >& v)
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

int main()
{
	std::vector<std::vector<double>> mat = get_matrix("mat.txt", ' ');
	// print matrix
	for(auto i: mat)
	{
		for(auto j: i) std::cout << j << " ";
		std::cout << "\n";
	}

    FlattenVector iter(mat);
    	while (iter.hasNext())
		cout << iter.next() << " ";
	return 0;
}
