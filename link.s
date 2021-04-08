;----------------------------------------------------;
; link.s - The main source file for the project      ;
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

BITS 32
default abs
segment flat

; In case functions need to aligned on a certain boundary, change this
bFuncAlignBoundary equ 1

; Special characters for use in strings
cNull       equ 0x00
cNewline    equ 0x0A
cTab        equ 0x09

 ;=====- END OF ASSEMBLER DIRECTIVES -=====;



      ;=====- START OF HEADER -=====;

; Special thanks to http://www.muppetlabs.com/~breadbox/software/tiny/teensy.html
org 0x08048000

bElfHeader:
    db  0x7F, "ELF", 1, 1, 1, 0 ; e_ident
    db  0, 0, 0, 0, 0, 0, 0, 0  ; (unusued/reserved)
    dw  2                       ; e_type
    dw  3                       ; e_machine
    dd  1                       ; e_version
    dd  _entry                  ; e_entry
    dd  bProgramHeader-$$       ; e_phoff
    dd  0                       ; e_shoff
    dd  0                       ; e_flags
    dw  bElfHeader_Size         ; e_ehsize
    dw  bProgramHeader_Size     ; e_phentsize
    dw  1                       ; e_phnum
    dw  0                       ; e_shentsize
    dw  0                       ; e_shnum
    dw  0                       ; e_shstrndx
bElfHeader_Size equ $-bElfHeader

bProgramHeader:
    dd  1                       ; p_type
    dd  0                       ; p_offset
    dd  $$                      ; p_vaddr
    dd  $$                      ; p_paddr
    dd  bFileLength             ; p_filesz
    dd  bFileLength             ; p_memsz
    dd  5                       ; p_flags
    dd  0x1000                  ; p_align
bProgramHeader_Size equ $-bProgramHeader

       ;=====- END OF HEADER -=====;



     ;=====- START OF CODE/DATA -=====;

%include "init.s"
%include "main.s"
%include "print.s"

      ;=====- END OF CODE/DATA -=====;



bFileLength equ $-$$
