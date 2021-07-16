[org 0x1000]

;;;___ARRIVE FROM THE BOOTLOADER HERE IN THE DEFAULT 16 BIT REAL MODE___;;;

	mov di, postBootSetupString
	call DisplayString
	call DisplayNewLine

	jmp EnterProtectedMode

postBootSetupString:
	db "The boot from a disk was a success.", 0

%include "../BootloaderAssembly/SoftwareInstructions/DisplayFunctions.asm"



;;;___BEGIN ENTERING 32 BIT PROTECTED MODE HERE___;;;

%include "../BootloaderAssembly/BootModeInstructions/GlobalDescriptorTable.asm"

AfterGDTCodeDescriptor: equ GDTCodeDescriptor - GDTNullDescriptor
AfterGDTDataDescriptor: equ GDTDataDescriptor - GDTNullDescriptor
                                                ; The label gets the code or data section, but is named
                                                ; to make its function more understandable during the "long" jump
EnterProtectedMode:
	call EnableA20
	cli
	lgdt [GDTDescriptor]
	mov eax, cr0
	or eax, 1
	mov cr0, eax
	jmp AfterGDTCodeDescriptor:ProtectedMode

EnableA20:
	in al, 0x92
	or al, 2
	out 0x92, al
	ret

[bits 32]                                       ; From this point on, BIOS interrupts aren't operational

ProtectedMode:
	mov ax, AfterGDTDataDescriptor
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

	mov [0xB8000], byte '3'
	mov [0xB8002], byte '2'
	mov [0xB8004], byte 'b'
	mov [0xB8006], byte ' '
	mov [0xB8008], byte 'k'
	mov [0xB800a], byte 'e'
	mov [0xB800c], byte 'r'
	mov [0xB800e], byte 'n'
	mov [0xB8010], byte 'e'
	mov [0xB8012], byte 'l'
	mov [0xB8014], byte '.'

	jmp $

times 2048-($-$$) db 0