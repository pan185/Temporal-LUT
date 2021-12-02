#include<stdio.h>
#include<stdlib.h>
#include<string.h>

//void matToRow (**int, int , int);
void matToRow(int**, int, int );
//void matToRow (**int, int , int);



void matToRow(int **arr2D, int n, int m){
    int *arr1D;
    int i, j;


    // allocating memeory to 1D dynamically
    // size of 1D array will be n*m
    arr1D = (int*)malloc(n * m * sizeof(int));

    for (i = 0; i < n; ++i) {
        for (j = 0; j < m; ++j) {
            // mapping 1D array to 2D array
            arr1D[i * m + j] = arr2D[i][j];
        }
    }

    printf("1D Array: ");

    for (i = 0; i < n * m; ++i) {
        printf("%d ", arr1D[i]);
    }
}

int main()
{

int **two_d[5][5];
matToRow(two_d,5,5);
    // Enter Matrix A
//    printf("Enter Number of Rows: ");
//    scanf("%d", &n);
//    printf("Enter Number of columns: ");
//    scanf("%d", &m);

//    printf("Enter 2D Array: \n");
//    for (i = 0; i < n; ++i) {
//        for (j = 0; j < m; ++j) {
//            scanf("%d", &arr2D[i][j]);
//        }
//    }

return 0;
}
