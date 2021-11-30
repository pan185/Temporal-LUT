////////////////////////////////////////////////////////////////////////////
// Author       : Aishwarya & Prajyot
// Department   : Grad Student @ Dept. of Electrical & Computer Engineering
// Contact      : pgupta54@wisc.edu
// Coursework   : ECE 751
// Description  : Addition-tree auto generation code
////////////////////////////////////////////////////////////////////////////

#include <iostream>
#include <array>
#include <string>

using namespace std;

int main(int argc, char* argv[])
{
    int row1=int(strtol(argv[1],NULL,10));
    int col1=int(strtol(argv[2],NULL,10));
    int row2=int(strtol(argv[3],NULL,10));
    int col2=int(strtol(argv[4],NULL,10));

    if (col1!=row2) {
        cout << "[ERROR] The two matrices are not compatible for Multiplication" << endl;
        return -1;
    }

    for (int i = 0; i < row1; i++) {
      for (int j = 0; j < col2; j++) {
            //cout << "mul_temp[" << i <<"][" << j << "] = ";
            cout << "mul_temp[" << i*row1+j << "] = ";
            for (int k = 0; k < col1; k++) {
                cout << "prod[" << i*col1+k << "][" <<k*col2+j <<"]";
                if (k!=col1-1) cout <<" + ";
        }
        cout << ";"<<endl;
        }
    }
    return 0;
}
