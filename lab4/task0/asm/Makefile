all: task0

task0: task0.o my_cmp.o
	gcc -m32 -g -Wall -o task0 task0.o my_cmp.o

task0.o: task0.c
	gcc -g -Wall -m32 -ansi -c -o task0.o task0.c
	
my_cmp.o: my_cmp.asm
	nasm -g -f elf -w+all -o my_cmp.o my_cmp.asm

clean:
	rm -rf *.o task0
