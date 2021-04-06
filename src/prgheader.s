ProgramHeader:
    dd  1                       ; p_type
    dd  0                       ; p_offset
    dd  $$                      ; p_vaddr
    dd  $$                      ; p_paddr
    dd  FileLength              ; p_filesz
    dd  FileLength              ; p_memsz
    dd  5                       ; p_flags
    dd  0x1000                  ; p_align
ProgramHeader_Size equ $-ProgramHeader
