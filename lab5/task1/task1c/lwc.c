
int open(char *name, int flags);

int close(int fd);

int read(int fd, char *buf, int size);

int write(int fd, char *buf, int size);

int strlen(char *s);

char *utoa(int numToStr);


#define EUSAGE    "usage: lwc [filename]\n"
#define EARGC    "error: wrong number of arguments\n"
#define ENOFILE "error: cannot open file\n"

#define BUFSIZE 512
char buffer[BUFSIZE];

#define WIDTH 64


/* print a string on stdout */
void print(char *s);

/* convert unsigned int to string */
char *utoa(int);

int main(int argc, char **argv) {

    int num = 123;
    char *strNum = utoa(num);
    return 0;
    
}
    


		
