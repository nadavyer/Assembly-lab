.PHONY: all clean

all: scmp

scmp: scmp.o cmpstr.o
	gcc -m32 -o scmp scmp.o cmpstr.o

cmpstr.o: cmpstr.c
	gcc -m32 -c -o cmpstr.o cmpstr.c

scmp.o: scmp.c
	gcc -m32 -c -o scmp.o scmp.c
	


clean:
	rm -rf *.o scmp
