#include <stdio.h>

extern int open(char fileName[]);
extern int close(int filedesc);

int main(int argc, char **argv) {
    int filedesc = open(argv[1]);
    printf("The corresponding file descriptor is %d \n", filedesc);

    int result = close(filedesc);
    if (result != -1) {
        printf("CLOSING DONE \n");
    } else {
        printf("CLOSING FAILED %d\n", result);
    }
    return 0;
}
