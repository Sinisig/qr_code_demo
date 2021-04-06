; Entrypoint for the application in here


align FuncAlignBoundary,nop
_entry:
    ; Call main with argc and argv
    mov edi, [esp + 0x00]   ; argc
    mov esi, [esp + 0x04]   ; argv
    call main
    
    ; Return to OS with the value returned from main
    mov ebx, eax
    mov al, 1
    int 0x80
