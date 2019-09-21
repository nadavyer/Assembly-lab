section .text
    global my_cmp            ; make my_cmp transparent to other modules

my_cmp:
    push ebp                 ; stack maintenance
    
    mov ebp, esp             ; stack maintenance
    push ebx
    ;call get_arguments       ; get args that were passed by C func
    ;jmp cmpare               ; compare args and exit

get_arguments:
    movzx eax, BYTE [ebp+8]  ; retrieves the first function argument, READ about MOVZX
    movzx ebx, BYTE [ebp+12] ; retrieves the second function argument, READ about MOVZX
  ; ret

cmpare:
    cmp eax, ebx             ; compare 2 ints
    jg F_BIG                 ; if first is bigger jum to F_BIG
    jmp S_BIG                ; otherwise jmp to F_BIG

F_BIG:
    mov eax, 1               ; return value need to be stored in eax register
    jmp FINISH

S_BIG:
    mov eax, 2               ; return value need to be stored in eax register
    jmp FINISH

FINISH:
    pop ebx
    mov esp, ebp  
    pop ebp                  ; stack maintenance
    ret                      ; stack maintenance
