; Entrypoint for the application in here


align bFuncAlignBoundary,nop
_entry:
    ; Call main with argc and argv
    mov edi, [esp]          ; argc
    lea esi, [esp + 4]      ; argv
    call main
    
    ; Return to OS with the value returned from main
    mov ebx, eax
    xor eax, eax
    inc al
    int 0x80
