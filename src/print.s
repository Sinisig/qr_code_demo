; This contains a bunch of utilities for printing/drawing


; void print_str(const char* str)
align bFuncAlignBoundary,nop
print_str:
    push ebx
    
    ; zero out registers here to maximize throughput
    xor edx, edx ; Used in the null terminator finding loop
    xor eax, eax ; Used in syscall
    xor ebx, ebx ; Used in syscall
    
    ; Get the string length(Find null terminator)
    .find_null_term:
        inc edx
        mov al, [edi + edx]
        test al, al
        jnz .find_null_term
    
    ; System call to print the string
    mov al, 4       ; syscall ID (write)
    inc bl          ; output file ID (stdout)
    mov ecx, edi    ; buffer (input string)
    int 0x80        ; perform syscall (syscall instruction doesn't work)
    
    pop ebx
    ret

; This prints a graph to the console, the input x is used at the x value for the center of the graph
; void draw_screen_graph(int x)
align bFuncAlignBoundary,nop
draw_screen_graph:
    push ebp
    mov ebp, esp
    sub esp, gWindowMemSize
    
    ;-----INITIALIZATION-----;
    
    mov edi, esi ; Save the anchor x value
    
    ; Clear registers and set with required values
    xor edx, edx
    xor eax, eax
    xor ecx, ecx
    mov edi, esp
    mov dl, gWindowSizeY
    mov al, gWindowBackgroundChar
    .init_loop:
        ; Set amount to fill and perform the copy
        mov cl, gWindowSizeX
        rep stosb
        
        ; Add a line break and increment stack offset (the rep stosb automatically moves us to the end of the row)
        mov byte [edi], cNewline
        inc edi
        
        ; Loop
        dec dl
        test dl, dl
        jnz .init_loop
    
    ; Finish with a null terminator
    mov byte [edi], cNull
    
    
    ;-----PLOTTING-----;
    
    xor ecx, ecx
    mov cl, gWindowSizeX
    .plot_loop:
        ; Todo: Plotting code
        
        loop .plot_loop
    
    ;-----PRINTING-----;
    
    ; Finally, print the calculated string to the console
    mov edi, esp
    call print_str
    
    ; Clean up and return
    add esp, gWindowMemSize
    leave
    ret
