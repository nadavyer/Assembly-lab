section .text
    global open
    global close

open:
    
    push ebp
    mov	ebp, esp
    push ebx
    push ecx
    

    
    mov eax, 5          ; sys_open
    mov ebx, [ebp+8]    ;filename ptr
    mov ecx, 2          ;the file is r+b
    int 0x80            ;syscall
    jmp finish
    
close:

    push ebp
    mov	ebp, esp
    push ebx
    push ecx
    
    mov eax, 6 ; sys_close 
    mov ebx, dword [ebp+8]
    int 0x80
  
    
finish:
    pop ecx
    pop ebx
    mov esp, ebp
	pop ebp
	ret
    
