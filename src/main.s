;===========================;
;=====- START OF MAIN -=====;
;===========================;


; int main(int argc, char** argv)
align bFuncAlignBoundary,nop
main:
    push ebp
    mov ebp, esp
    
    ; Clear screen and print credits
    mov edi, str_credits
    call print_str
    
    ; Test code for the graphing function
    pxor xmm0, xmm0
    call draw_screen_graph
    
    leave
    ret

str_credits:    db 0x1B, 0x5B, 0x32, 0x4A
                db cTab, "-QR Code demo by Sinisig-"                ,cNewline
                db "https://www.github.com/Sinisig/qr_code_demo"    ,cNewline
                db cNewline, cNewline
                db cNull
