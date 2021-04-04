bits 32

%include "print.i"

global main


section .rodata
    str_watermark:  db "        -QR Code demo by Sinisig-", 0x0A
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

section .text

;===========================;
;=====- START OF MAIN -=====;
;===========================;
main:
    push ebp
    mov ebp, esp
    
    ; Watermark for the binary
    mov edi, str_watermark
    call print_str
    
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
