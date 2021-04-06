;===========================;
;=====- START OF MAIN -=====;
;===========================;


align bFuncAlignBoundary,nop
main:
    push ebp
    mov ebp, esp
    
    ; Startup credits/watermark
    mov edi, str_credits
    call print_str
    
    xor eax, eax
    leave
    ret

str_credits:    db "        -QR Code demo by Sinisig-", 0x0A
                db "https://www.github.com/Sinisig/qr_code_demo", 0x0A
                db 0x0A, 0x0A, 0x00
