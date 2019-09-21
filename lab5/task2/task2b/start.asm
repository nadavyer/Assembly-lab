section .data
    bufsize dw 50
    numOfLinesStr: db 'Number of lines: ', 0     ;to write
    numOfLinesStrLen: equ  $ - numOfLinesStr    ;length to save bytes for    
    openFileError: db 'Failed to open the file', 10, 0      ;constant lines to be witten
    openopenFileErrorLen: equ  $ - openFileError
    closeFileError: db 'Failed to close the file', 10, 0
    closeFileErrorLen: equ  $ - closeFileError
    readFileError: db 'Failed to read from file', 10, 0
    readFileErrorLen: equ  $ - readFileError
    write_to_File_err: db 'Failed to write to file', 10, 0
    write_to_File_err_len: equ  $ -  write_to_File_err
    lOperator: db '-l'
    endLineOperator: db '\n'
    totalLines dw 0
    lFlag dw 0
    
    
  

section .bss
   buf     resb    50
    strNumber resb 16
   filePath resb 40
  
section .text
	
global _start
global read
global write
global open
global close
global strlen
global utoa
global cmpstr

_start:
	pop eax ;argc
	pop eax ; argv[0]
	pop eax ;argv[1]
	;mov filePath, eax
	push esi 
	push eax
	push lOperator
	mov esi, eax
	call cmpstr
	cmp eax, 0
	jne preOpen
	jmp handle

handle: 
        ;L seitch run here
	mov 	ecx,0 ; set counter
	
	pop dword ebx ; get argv[1]		
	
	push 0; 	
	push 2; 	read write
	push ebx; 	file

	call	open
	mov esi, eax
ReadLLoop:

	push bufsize	
	push buf
	push esi ; fd
	call read 
	
	cmp eax, 0
	jg LLogic

	;closing and printing
	push esi ; fd
	call close
	
	; printing num of lines
	;calling convert int to string

	push 	ecx
	call	utoa
	;here the enter
	;mov esi, strNumber	; point eax to string
	;mov dl, 10
	;mov [esi+1] , dl

	
	push 50 ; num of bytes to wrtie
	push strNumber ; buff contains number to show
	push 1
	call write

	;exit code
	mov     ebx,0	; put syscall value of what in eax we need to put in eax 0 at the end 
	mov	eax,1 	; 
	int 0x80 	;call syscall


LLogic:
	mov	edx, -1 ;logic of code

InnerLoop:
	add edx, 1
	mov ebx, edx
	add ebx, buf
	movzx	ebx, BYTE [ebx]
	
	cmp	ebx,10
	jne ContinueInnerLoop
	add 	ecx,1 ; add to counter
	
ContinueInnerLoop:
	sub eax,1
	cmp eax, 0
	jg InnerLoop

	;finish reading buff
	jmp ReadLLoop


        
        
preOpen:
	push 2 ; read and write  
	push esi ; file
	call open
	call reading
	

	
reading:
        push bufsize 
        push buf
	push eax ; descriptor
	call read

	cmp eax, 0
	jg to_print
	call close
	
	
	; exit
        mov     ebx,eax
	mov	eax,1
	int 0x80
	
to_print:
    push bufsize
	push buf
	push 1
	call write
	call reading

read:
    	push ebp
	mov ebp, esp
	push ebx
	push ecx
	push edx
	
    mov eax, 3      ;system call num
	mov ebx, dword [ebp+8]     ;file descriptor 
	mov ecx, [ebp+12]      ;pointer to input buffer
	mov edx, [ebp+16]      ;buffer size, max count of bytes recive
	int 0x80
	
	pop edx
	pop ecx
	pop ebx
	pop ebp
	ret

	
write:
        push ebp
	mov ebp, esp
	
	push ebx
	push ecx
	push edx
	
        mov eax, 4
	mov ebx, dword [ebp+8]
	mov ecx, [ebp+12]
	mov edx, [ebp+16]
	int 0x80
	
	
	pop edx
	pop ecx
	pop ebx
	
	
	pop ebp
	ret
open:

    push ebp        ;stack maintance
	mov ebp, esp       ;stack maintance
	push ebx
	push ecx
	push edx
	
    mov eax, 5      ;system call num
	mov ebx, dword [ebp+8]     ;pathname of file to create
	mov ecx, [ebp+12]      ;file acces bits
	mov edx, [ebp+16]      ;file permissions
	int 0x80
	
	
	pop edx
	pop ecx
	pop ebx
	pop ebp
	ret
	
	
close:

    push ebp
	mov ebp, esp
	push ebx
	
	mov eax, 6     ;system call num
	mov ebx, dword [ebp+8]     ;file descriptor
	int 0x80
	
    	pop ebx
	pop ebp
	ret


strlen:                        ;from lab4 task1

    push	ebp                ;stack maintance
	mov	ebp, esp               ;stack maintance
	push ebx
	mov	eax,-1                 ;initialize eax with -1

.L2:
	add eax, 1                 ;add 1 to eax
	mov ebx, eax               ;initialize ebx with eax val
	add ebx, [ebp+8]           ;add the 1st (index 1) argument of strlen to ebx
	movzx	ebx, BYTE [ebx]    ;ebx get 8 bits of ebx and the rest are 0s
	test bl,bl                 ;computes the bit-wise logical AND of bl and bl - affects the ZF (zero flag). bl contains the                                   
                                ;low bytes of ebx
	
	jne .L2                    ;jump to .L2 is not all the bits are 0s (if all 0s so reached last already)           
	pop ebx
	mov esp, ebp               ;stack maintance
	pop ebp                    ;stack maintance    
	ret                        ;return call
	
utoa:
        push ebp
	mov ebp, esp
	push ebx
	push ecx
	push edx
	
	xor eax, eax       ;reset eax
	xor ebx, ebx       ;reset ebx
	mov eax, [ebp+8]   ;set eax on argument (int recived)
	mov ebx, 10        ;sev divisor to 10
	mov ecx, 0         ;set counter- for each dev we get one digit
	
devide:
            xor edx, edx    ;reset eax
        div ebx     ;eax = quotient, edx = remainder
        add edx, '0'        ;to make the reminder char
        push edx        ;push the char (of digit)
        inc ecx ; loop counter
        test eax, eax       ;loop until quotient is 0
        jne devide          
        xor ebx, ebx        ;reset ebx
        xor edx, edx        ;reset edx
        
digitToChar:
        add ebx, strNumber      ;set ebx to point strNum
        pop eax     ;set in eax the char that represent 1 digit 1 digit
        mov [ebx], eax      ;set the char value in the string 
        inc edx     ;inc edx to go next char on string
        mov ebx, edx        ;to promote the ebx to next digit for next loop
        loop digitToChar        ;loop until ecx xount is 0
    pop edx
    pop ecx
    pop ebx
	mov eax,strNumber      ;eax ptr to the string
	pop ebp
	ret
cmpstr:

    push ebp        ;stack maintance                 
    mov ebp, esp    ;stack maintance        
    push ebx        ;push ebx reg
    push ecx        ;push ecx reg
    mov eax, -1     ;initialize eax
    
.loop: 
    
    add eax, 1      ;inc eax
    mov ebx, eax    ;set eax in ebx 
    mov ecx, eax    ;set eax in ecx
    add ebx, [ebp+8];set the 1st argument val in ebx
    add ecx, [ebp+12]; set the 2nd argument val in ecx
    movzx ebx, BYTE [ebx]; set the ebx val (8 bits) in ebx and the rest are 0s
    movzx ecx, BYTE [ecx]; set the ecx val (8 bits) in ecx and the rest are 0s
    
    cmp ebx, ecx    ;compare ebx and ecx
    jg F_BIG
    jl S_BIG
    test bl, bl
    je check_c
    test cl, cl
    je check_b
    jmp .loop
    
    
    

F_BIG:
    mov eax, 1               
    jmp FINISH

S_BIG:
    mov eax, 2              
    jmp FINISH

E_BIG:
    mov eax, 0
    jmp FINISH

check_b:
    test bl, bl
    je E_BIG
    jmp S_BIG
    
check_c:
    test cl, cl
    je E_BIG
    jmp F_BIG
    

FINISH:
    pop ecx
    pop ebx
    mov esp, ebp  
    pop ebp                 
    ret                      
