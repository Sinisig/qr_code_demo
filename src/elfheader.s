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
