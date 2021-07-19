DisplayHexadecimal:
    mov cx, 4	                      ; offset in string, counter (4 hex characters)
    .displayHexadecimalLoop:
    mov ax, dx	                      ; Hex word passed in DX
    and al, 0Fh                       ; Use nibble in AL
    mov bx, hexadecimalToAsciiConstant
    xlatb                             ; AL = [DS:BX + AL]

    mov bx, cx                        ; Need bx to index data
    mov [hexadecimalString+bx+1], al  ; Store hex char in string
    ror dx, 4                         ; Get next nibble
    loop .displayHexadecimalLoop 
        mov si, hexadecimalString     ; Print out hex string
        mov ah, 0Eh
        mov cx, 6                     ; Length of string
        .loop:
        lodsb
        int 10h
        loop .loop
            ret

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

hexadecimalString: db '0x0000'
hexadecimalToAsciiConstant: db '0123456789ABCDEF'