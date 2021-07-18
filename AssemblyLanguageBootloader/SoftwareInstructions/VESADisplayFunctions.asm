VESAClearScreen:
    push eax
    push ecx
    push edi

    mov edi, [5028h]                            ; Physical address base pointer (Frame buffer) of mode info block set during "Post Boot Setup"
    mov ecx, 1980*1080                          ; ARGB 32 bytes per pixel (bpp)
    mov eax, 0000FFh                            ; ARGB coloring [Alpha|Red|Green|Blue] 8 bits per set / 1 byte per set, EG: 0000FFh=11111111=255=blue
    rep stosd

    hlt ; change to not halt