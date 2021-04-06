bProgramHeader:
    dd  1                       ; p_type
    dd  0                       ; p_offset
    dd  $$                      ; p_vaddr
    dd  $$                      ; p_paddr
    dd  bFileLength              ; p_filesz
    dd  bFileLength              ; p_memsz
    dd  5                       ; p_flags
    dd  0x1000                  ; p_align
bProgramHeader_Size equ $-bProgramHeader
