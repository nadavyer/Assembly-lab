section .text
    global cmpstr            

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
    test ,mbl, bl
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
