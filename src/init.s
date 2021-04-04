bits 32

global _entry
extern main


section .text

_entry:
    ; Call main with argc and argv
    mov edi, [esp + 0x00]   ; argc
    mov esi, [esp + 0x04]   ; argv
    call main
    
    ; Return to OS with the value returned from main
    mov ebx, eax
    xor eax, eax
    inc eax
    int 0x80
