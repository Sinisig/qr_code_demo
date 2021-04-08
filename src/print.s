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


; This prints a graph to the console, the input x is used at the ending x value
; void draw_screen_graph(int a)
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
    
    addss xmm0, [gWindowCenter] ; Centers the graph properly
    xor ecx, ecx
    mov cl, gWindowSizeX
    .plot_loop:
        ; Run the graphing function f(x)
        ; f(x) = x^2 - 1
        movss xmm1, xmm0
        mulss xmm1, xmm0
        addss xmm1, [gFunctionConst_NOne]
        
        ; Multiply by the vertical screen ratio and convert to an integer, store in edx
        mulss xmm1, [gWindowRatioY]
        cvtss2si eax, xmm1
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
        ; Loop
        addss xmm0, [gWindowRatioX]
        loop .plot_loop
        
    
    ;-----PRINTING-----;
    
    ; Finally, print the calculated string to the console
    mov edi, esp
    call print_str
    
    ; Clean up and return
    add esp, gWindowMemSize
    leave
    ret

; Assembler directives, defines, and memory addresses down here
; Modify these if you want to edit the appearance of the window
gWindowSizeX            equ 43          ; The amount of horizontal characters
gWindowSizeY            equ 13          ; The amount of vertical characters
gWindowBackgroundChar   equ ' '         ; The character used for empty space
gWindowForegroundChar   equ '#'         ; The character used for plotted dots
%define gWindowRangeX       7.0        ; The range of X values to calculate
%define gWindowRangeY       2.0         ; The range of Y values to display
%define gWindowTextRatio    (17.0/10.0)  ; The ratio of the text characters

gWindowArea             equ gWindowSizeX * gWindowSizeY
gWindowMemSize          equ gWindowArea + gWindowSizeY + 1  ; This takes into account the line breaks and null terminator
; TODO: Use NASM to calculate these instead of calculating them manually
align 4,nop
gWindowCenter:          dd  0x40600000 ; gWindowRangeX / 2
gWindowRatioX:          dd  0xBE26B29B ; gWindowRangeX / gWindowSizeX * -1
gWindowRatioY:          dd  0xC074B4B5 ; gWindowSizeY / (gWindowRangeY * gWindowTextRatio) * -1
gFunctionConst_NOne:    dd  0xBF800000 ; -1
