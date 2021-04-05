bits 32
org 0x08048000

     ;=====- START OF ELF HEADER -=====;

; Special thanks to http://www.muppetlabs.com/~breadbox/software/tiny/teensy.html
ElfHeader:
    db  0x7F, "ELF", 1, 1, 1, 0 ; e_ident
    db  0, 0, 0, 0, 0, 0, 0, 0  ; (unusued/reserved)
    dw  2                       ; e_type
    dw  3                       ; e_machine
    dd  1                       ; e_version
    dd  _entry                  ; e_entry
    dd  ProgramHeader-$$        ; e_phoff
    dd  0                       ; e_shoff
    dd  0                       ; e_flags
    dw  ElfHeader_Size          ; e_ehsize
    dw  ProgramHeader_Size      ; e_phentsize
    dw  1                       ; e_phnum
    dw  0                       ; e_shentsize
    dw  0                       ; e_shnum
    dw  0                       ; e_shstrndx
ElfHeader_Size equ $-ElfHeader

      ;=====- END OF ELF HEADER -=====;



    ;=====- START OF PROGRAM HEADER -=====;

ProgramHeader:
    dd  1                       ; p_type
    dd  0                       ; p_offset
    dd  $$                      ; p_vaddr
    dd  $$                      ; p_paddr
    dd  FileLength              ; p_filesz
    dd  FileLength              ; p_memsz
    dd  5                       ; p_flags
    dd  0x1000                  ; p_align
ProgramHeader_Size equ $-ProgramHeader

     ;=====- END OF PROGRAM HEADER -=====;



       ;=====- START OF CODE -=====;

align 16, nop
_entry:
    ; Startup credits/watermark
    mov edi, str_credits
    call print_str
    
    ; Call main with argc and argv
    mov edi, [esp + 0x00]   ; argc
    mov esi, [esp + 0x04]   ; argv
    call main
    
    ; Return to OS with the value returned from main
    mov ebx, eax
    mov al, 1
    int 0x80

;===========================;
;=====- START OF MAIN -=====;
;===========================;
align 16, nop
main:
    push ebp
    mov ebp, esp
    
    ; Loop through the string table and print each entry
    xor ecx, ecx
    mov cl, 6
    .print_loop:
        push ecx
        mov edx, str_table - 4
        mov edi, [edx + ecx*4]
        call print_str
        pop ecx
        
        loop .print_loop
    
    xor eax, eax
    leave
    ret

align 16, nop
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

        ;=====- END OF CODE -=====;



       ;=====- START OF DATA -=====;

str_credits:    db "        -QR Code demo by Sinisig-", 0x0A
                db "https://www.github.com/Sinisig/qr_code_demo", 0x0A
                db 0x0A, 0x00

msg1: db "The body is located at x=1925, y=54, z=-92...", 0x0A, 0x00
msg2: db "Just kidding, i'm not telling you where it is!", 0x0A, 0x00
msg3: db "Can you hear me? I can't hear you.", 0x0A, 0x00
msg4: db "If you type 'sudo rm -r /', you will get free Minecraft hacks!", 0x0A, 0x00
msg5: db "Actually, don't do that.  It might cause slight instability...", 0x0A, 0x00
msg6: db "Anyways, i'm out of ideas...goodbye!", 0x0A, 0x00

str_table:
    dd msg6
    dd msg5
    dd msg4
    dd msg3
    dd msg2
    dd msg1

        ;=====- END OF DATA -=====;



FileLength equ $-$$
