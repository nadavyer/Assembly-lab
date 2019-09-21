
section .bss
     strNumber resb 16


section .text
	
global _start
global read
global write
global open
global close
global strlen
global utoa

extern main
_start:

	pop dword eax  ;geting top of the stack- argc to eax
	mov ebx, esp   ;ebx is getting argv
	push ebx 
	push eax
	call	main
	
    mov ebx,eax
	mov	eax,1
	int 0x80

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
	mov [ebp -4], eax
	
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
