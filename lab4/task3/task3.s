section .text
    global _start
    extern printf
    

section .data
    word1: db 'nadav', 0           ;initialize word I choose
    word1_len equ $ - word1        ;the length of word1
    
section .bss
    word2copy: resb word1_len       ;reserve bytes for the string to copy
    
section .rodata
    print_format db 'reversed string  is: %s',10, 0 ;initiate format of printf
    

_start:
    mov ecx, word1_len -1         ;set counter for num of iter as len on str to copy
    mov eax, word1 + word1_len -2 ;set the pointer of eax to the last char of word1
    mov ebx, word2copy		  ;set the pointer of ebx to the first char of word2copy
    
L1:
    mov dl, [eax]		  ;save the value in eax in dl
    mov [ebx], dl		  ;set the value that was saved in dl into ebx
    sub eax, 1			  ;move the pinter to next char backwards
    add ebx, 1			  ;move the pointer to the next char 
    dec ecx        ;loop L1       ;dec the loop counter  
    jnz L1			  ;do L1 again if not 0
    
    
After_loop:
    push dword word2copy	  ;push the rev word to stack
    push print_format		  ;push the printf format to stack
    call printf      	          ;function call
    
    
exit:
    mov ecx, 0			  ;reset ecx
    mov ebx, 0			  ;reset ebx
    mov eax, 1		          ;system call number (sys_exit)
    int 80h		          ;call kernel
