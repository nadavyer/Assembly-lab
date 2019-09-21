section .text
	global funcA
	
funcA:
	push ebp 		;stack maintance
	mov ebp, esp               ;stack maintance
	push ebx
	mov eax,-1                 ;initialize eax with -1

.L2:
	add eax, 1                 ;add 1 to eax
	mov ebx, eax               ;initialize ebx with eax val
	add ebx, [ebp+8]           ;add the 1st (index 1) argument of funcA to ebx
	movzx ebx, BYTE [ebx]      ;ebx get 8 bits of ebx and the rest are 0s
	test bl,bl                 ;computes the bit-wise logical AND of bl and bl - affects the ZF 				(zero flag). bl contains the low bytes of ebx                               
	jne .L2                    ;jump to .L2 is not all the bits are 0s (if all 0s so reached last already)
         
	pop ebx	  
	mov esp, ebp               ;stack maintance
	pop ebp                    ;stack maintance    
	ret                        ;return call
