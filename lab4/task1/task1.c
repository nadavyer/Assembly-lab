#include <stdio.h>

extern int funcA(char* ch1);

int main(int argc, char **argv){
  int res;
  char *argument = argv[1];
  res = funcA(argument);
  printf("The result is %d \n",res);
	
  return 0;
}
