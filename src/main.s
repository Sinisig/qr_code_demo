;===========================;
;=====- START OF MAIN -=====;
;===========================;


; int main(int argc, char** argv)
align bFuncAlignBoundary,nop
main:
    push ebp
    mov ebp, esp
    
    ; Credits/Watermark and Screen Clearer
    mov edi, str_credits
    call print_str
    
    ; TEST CODE
    xor edi, edi
    call draw_screen_graph
    
    xor eax, eax
    leave
    ret

str_credits:    db cTab, "-QR Code demo by Sinisig-", cNewline
                db "https://www.github.com/Sinisig/qr_code_demo", cNewline
                db cNewline, cNewline
                db cNull
