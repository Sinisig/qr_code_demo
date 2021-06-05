%include "qr_code.i"
%include "print.i"


section .rodata
   str_credits:   db 0x1B, 0x5B, 0x32, 0x4A
                  db cTab, "-QR Code demo by Sinisig-",              cNewline
                  db "https://www.github.com/Sinisig/qr_code_demo",  cNewline
                  db cNewline
                  db cNull

section .text

; int main(int argc, char** argv)
global main
main:
   push  rbp
   mov   rbp, rsp

   ;Clear screen and print credits
   mov   rdi, str_credits
   call  print_str

   ;Test code for the graphing function
   pxor  xmm0, xmm0
   call  draw_screen_graph

   xor   rax, rax
   leave
   ret
