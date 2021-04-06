; Entrypoint for the application in here


align bFuncAlignBoundary,nop
_entry:
    ; Call main with argc and argv
    mov esi, esp
    mov edi, [esp]          ; argc
    add esi, 4              ; argv
    call main
    
    ; Return to OS with the value returned from main
    mov ebx, eax
    mov al, 1
    int 0x80
