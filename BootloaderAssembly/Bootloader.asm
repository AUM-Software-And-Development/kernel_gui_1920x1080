[org 0x7C00]

    mov [BOOT_DISK], dl
    mov bp, 0x7C00
    mov sp, bp

    mov di, bootloaderString
    call DisplayString
    call DisplayNewLine

    call ReadDisk
    jmp KERNEL_ADDRESS

%include "../BootloaderAssembly/SoftwareInstructions/DisplayFunctions.asm"
%include "../BootloaderAssembly/HardwareInstructions/ReadDiskFunctions.asm"

KERNEL_ADDRESS: equ 0x1000

BOOT_DISK: db 0

bootloaderString:
    db "Booted from floppy.", 0 

times 510-($-$$) db 0

dw 0xAA55