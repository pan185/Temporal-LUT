
#include <stdio.h>
#include <stdlib.h>
#include <iostream>

int main() {

FILE *fp; 
fp = fopen ("input_small.mat","r");
if (fp){
std::cout << fp << std::endl;
printf("hello world");
}
fclose(fp);
return 0;
}
