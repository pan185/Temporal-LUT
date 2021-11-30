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
    int dim=int(strtol(argv[1],NULL,10));

    for (int i = 0; i < dim; i++) {
      for (int j = 0; j < dim; j++) {
            cout << "mul_temp[" << i <<"][" << j << "] = ";
            for (int k = 0; k < dim; k++) {
                cout << "prod[" << i*dim+k << "][" <<k*dim+j <<"]";
                if (k!=dim-1) cout <<" + ";
        }
        cout << ";"<<endl;
        }
    }
    return 0;
}
