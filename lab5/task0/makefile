all: prog

prog: prog.o handler.o 
	gcc -m32 -g -Wall -o prog prog.o handler.o

prog.o: prog.c
	gcc -g -m32 -c -o prog.o prog.c

handler.o: handler.s
	nasm -g -f elf -w+all -o handler.o handler.s

clean:
	rm -rf *.o prog
