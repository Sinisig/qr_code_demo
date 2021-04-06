;----------------------------------------------------;
; qr_binary.s - The main source file for the project ;
;                                                    ;
; The ELF Binary is manually created in order to     ;
; save on space and have more control.               ;
;                                                    ;
; In order to improve readability and managability,  ;
; the preprocessor is used to "link" source files by ;
; including them like a header file.                 ;
;                                                    ;
; Holy fuck this has become complicated...           ;
;----------------------------------------------------;

;=====- START OF ASSEMBLER DIRECTIVES -=====;

CPU 386
BITS 32
default abs
segment flat

bFuncAlignBoundary equ 1

gWindowSizeX equ 3
gWindowSizeY equ 2
gWindowArea  equ gWindowSizeX * gWindowSizeY
gWindowMemSz equ gWindowArea + gWindowSizeY + 1 ; This takes into account the line breaks and null terminator

 ;=====- END OF ASSEMBLER DIRECTIVES -=====;



      ;=====- START OF HEADER -=====;

; Special thanks to http://www.muppetlabs.com/~breadbox/software/tiny/teensy.html
org 0x08048000
%include "elfheader.s"
%include "prgheader.s"

       ;=====- END OF HEADER -=====;



     ;=====- START OF CODE/DATA -=====;

%include "init.s"
%include "main.s"
%include "print.s"

      ;=====- END OF CODE/DATA -=====;



bFileLength equ $-$$
