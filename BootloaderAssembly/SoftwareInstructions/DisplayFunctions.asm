DisplayNewLine:
    mov ah, 0x0E
    mov al, 0x0A
    int 0x10
    mov al, 0x0D
    int 0x10
    ret

DisplayString:
    mov ah, 0x0E
.loop:
    mov al, [di]
    cmp al, 0
    je .exit
        int 0x10
        inc di
        jmp .loop
.exit:
    ret