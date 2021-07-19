VESAClearScreen:
    pusha                                                               ; If registers aren't pushed here, there are errors

    mov edi, [VESA_MODE_INFO_BLOCK_ADDRESS + 28h]                       ; Physical address base pointer (Frame buffer) of mode info block set during "Post Boot Setup"
    mov ecx, 1980*1080                                                  ; ARGB 32 bytes per pixel (bpp)
    mov eax, 0000FFh                                                    ; ARGB coloring [Alpha|Red|Green|Blue] 8 bits per set / 1 byte per set, EG: 0000FFh=11111111=255=blue
    rep stosd

    popa                                                                ; Return the state before going back to the system controller
    ret