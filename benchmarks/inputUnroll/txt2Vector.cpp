////////////////////////////////////////////////////////////////////////////
// Author       : Jeneel
// Coursework   : ECE 751
// Function     : get_matrix
// Description  : get matrix from txt file and convert to vector
////////////////////////////////////////////////////////////////////////////


#include <iostream>
#include <string>
#include <fstream>
#include <vector>


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


 int main()
 {
 	std::vector<std::vector<double>> mat = get_matrix("mat.txt", ' ');
 	// Let's display our matrix
 	for(auto i: mat)
 	{
		for(auto j: i) std::cout << j << " ";
 		std::cout << "\n";
 	}
 }
