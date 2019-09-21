section .text
	
global _start
global read
global write
global open
global close
global strlen

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
	
        mov eax, 4      ;sys call num
	mov ebx, dword [ebp+8]     ;file descriptor
	mov ecx, [ebp+12]      ;pointer to input buffer    
	mov edx, [ebp+16]      ;buffer max size
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
	
