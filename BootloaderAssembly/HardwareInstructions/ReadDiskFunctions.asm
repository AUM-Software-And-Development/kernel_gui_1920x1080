; AH = 02
; AL = Number of sectors to read (1-128 decimal)
; CH = Track/cylinder number (0-1023 decimal, see below)
; CL = Sector number (0-17 decimal)
; DH = Head number (0-15 decimal)
; DL = Drive number (0=A:, 1=2nd floppy, 80h=drive 0, 81h=drive 1)

; On return:
; AH = Status
; AL = Number of sectors that were read
; CF = 0 (if success)
; CF = 1 (if error)

; The documentation recommends the programmer attempts at least 3 times to read a disk if there's an error.
; That would be due to potential for traffic noise (talking) on the bus/motherboard, or mechanical bouncing.

ReadDisk:
    mov di, readDiskString
    call DisplayString
    call DisplayNewLine

    mov ah, 0x02                                ; BIOS disk read function
    mov al, 4                                   ; Amount of sectors to read
    mov ch, 0                                   ; Cylinder
    mov cl, 2                                   ; Sector
    mov bx, KERNEL_ADDRESS                      ; Address to load to
    mov dh, 0                                   ; Head
    mov dl, [BOOT_DISK]                         ; Disk

    int 0x13
    jc .error

    mov di, readDiskSuccessString
    call DisplayString
    call DisplayNewLine

    ret
.error:
    mov di, readDiskErrorString
    call DisplayString
    call DisplayNewLine

readDiskString:
    db "A call to ReadDisk was made.", 0

readDiskErrorString:
    db "There was an unspecified error while attempting to read from the disk.", 0

readDiskSuccessString:
    db "The disk was read without error.", 0