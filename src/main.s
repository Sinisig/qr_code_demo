;===========================;
;=====- START OF MAIN -=====;
;===========================;


; int main(int argc, char** argv)
align bFuncAlignBoundary,nop
main:
    push ebp
    mov ebp, esp
    
    ; Startup credits/watermark
    mov edi, str_credits
    call print_str
    
    ; Test code for drawing a graph to the screen
    xor edi, edi
    call draw_screen_graph
    
    xor eax, eax
    leave
    ret

str_credits:    db "        -QR Code demo by Sinisig-", 0x0A
                db "https://www.github.com/Sinisig/qr_code_demo", 0x0A
                db 0x0A, 0x0A, 0x00
