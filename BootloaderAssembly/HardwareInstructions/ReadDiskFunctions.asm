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

; The documentation recommends that the programmer attempt to read a disk at least 3 times if it fails.
; This is because motherboards can have unexpected noise or circuitry bounces from its processes, 
; or depending on build quality.

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

; Registers are summable; EG: mov ch, 0 \n mov cl, 2 is equal to writing one code line: mov cx, 0000000000000010b
; or mov cx, 0x2 in hexadecimal

; The reason that I don't do that, is because these types of things are hardcoded into some of the hardware
; setup patterns, and it makes things very daunting for newcomers to boot into protected modes.
; I don't believe that it's necessary to learn things the hard way, and I'd rather see people get started first,
; then come back to learn some of the more in depth details when they feel they are ready.