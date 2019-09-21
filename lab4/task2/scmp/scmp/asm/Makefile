.PHONY: all clean

all: clean scmp

scmp: scmp.o cmpstr.o
	gcc -m32 -g -o scmp scmp.o cmpstr.o

scmp.o: scmp.c
	gcc -m32 -g -c -o scmp.o scmp.c

cmpstr.o: cmpstr.s
	nasm -g -f elf -w+all -o cmpstr.o cmpstr.s


	


clean:
	rm -rf *.o scmp
