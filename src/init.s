%include "qr_code.i"

extern main


section .text

global _entry
_entry:
   ; Align the stack and call main with argc and argv
   mov   rdi, [rsp]     ; argc
   lea   rsi, [rsp + 8] ; argv
   call  main

   ; Return to OS with the value returned from main
   mov   rdi, rax
   xor   rax, rax
   mov   al, 60
   syscall
