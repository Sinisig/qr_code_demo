bits 32

global print_str


section .text

print_str:
    ; Get the string length(Find null terminator)
    xor edx, edx
    dec edx
    .loop:
        inc edx
        mov al, [edi + edx]
        test al, al
        jnz .loop
    
    ; System call to print the string
    mov al, 4       ; syscall ID (write)
    xor bl, bl      ; output file ID (stdout)
    mov ecx, edi    ; buffer (input string)
    inc bl
    int 0x80        ; perform syscall (syscall instruction doesn't work)
    
    ret
