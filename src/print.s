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


; This prints a graph to the console, the input x is used at the starting x value
; void draw_screen_graph(int x)
align bFuncAlignBoundary,nop
draw_screen_graph:
    push ebp
    mov ebp, esp
    sub esp, gWindowMemSize
    
    ;-----INITIALIZATION-----;
    
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
        ; Calculate the function and store the result(in terms of the screen resolution) in edx
        ; This is a test function btw
        lea edx, [ecx - gWindowSizeY*2]
        
        ; Negate the Y value (so it's on the graph correctly) and add half the height to make it centered
        xor eax, eax
        dec eax
        imul edx
        add eax, gWindowSizeY / 2
        
        ; Calculate the offset into the table
        ; index = ((gWindowSizeX + 1) * y) + x
        xor edx, edx
        mov dl, gWindowSizeX + 1
        imul edx
        add eax, ecx
        
        ; Make sure it's within bounds of the table ( Segmentation fault (core dumped) )
        cmp eax, gWindowArea + gWindowSizeY
        jg .skip_plot
        cmp eax, 0
        jl .skip_plot
        
        ; Perform the write
        mov byte [esp + eax-1], gWindowForegroundChar
        
        .skip_plot:
        loop .plot_loop
        
    
    ;-----PRINTING-----;
    
    ; Finally, print the calculated string to the console
    mov edi, esp
    call print_str
    
    ; Clean up and return
    add esp, gWindowMemSize
    leave
    ret
