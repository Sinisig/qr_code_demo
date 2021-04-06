; This contains a bunch of utilities for printing/drawing


align FuncAlignBoundary,nop
print_str:
    push ebx
    
    ; Get the string length(Find null terminator)
    xor edx, edx
    .loop:
        inc edx
        mov al, [edi + edx]
        test al, al
        jnz .loop
    
    ; System call to print the string
    mov al, 4       ; syscall ID (write)
    mov bl, 1       ; output file ID (stdout)
    mov ecx, edi    ; buffer (input string)
    int 0x80        ; perform syscall (syscall instruction doesn't work)
    
    pop ebx
    ret

; This is horribly broken atm, debugging is impossible right now because DDD/GDB refuse to work
align FuncAlignBoundary,nop
draw_screen_graph:
    push ebp
    mov ebp, esp
    push ebx
    sub esp, WindowMemSz
    
    mov edi, esp
    xor ebx, ebx
    mov bl, WindowSizeY
    .init_loop:
        ; Set up and perform the store
        xor eax, eax
        xor ecx, ecx
        mov al, 'X'
        mov cl, WindowSizeX
        rep stosb
        
        ; Line break
        mov byte [edi + WindowSizeX], 0x0A
        
        ; Update the offset
        add edi, WindowSizeX+1
        
        ; Loop
        dec bl
        test bl, bl
        jnz .init_loop
    
    ; Null Terminator
    mov byte [esp + WindowMemSz - 1], 0x00
    
    ; Print the string
    mov edi, esp
    call print_str
    
    add esp, WindowMemSz
    pop ebx
    leave
    ret
