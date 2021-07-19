[org 0x7C00]

    mov [BOOT_DISK], dl

    mov di, bootloaderString
    call DisplayString
    call DisplayNewLine

    call ReadDisk
    jmp 0x0000:POST_BOOT_SETUP_ADDRESS

ORIGIN_ADDRESS: equ 0x7C00

POST_BOOT_SETUP_ADDRESS: equ 0x1000

BOOT_DISK: db 0

bootloaderString:
    db "Booted from floppy.", 0 

%include "../../AssemblyLanguageBootloader/SoftwareInstructions/Int0x10DisplayFunctions.asm"
%include "../../AssemblyLanguageBootloader/HardwareInstructions/ReadDiskFunctions.asm"

times 510-($-$$) db 0

dw 0xAA55