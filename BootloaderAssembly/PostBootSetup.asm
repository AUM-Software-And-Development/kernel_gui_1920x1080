[org 0x1000]

;;;___ARRIVE FROM THE BOOTLOADER HERE IN THE DEFAULT 16 BIT REAL MODE___;;;

	mov di, postBootSetupString
	call DisplayString
	call DisplayNewLine

	jmp EnterProtectedMode32Bits

postBootSetupString:
	db "The boot from a disk was a success.", 0

%include "../BootloaderAssembly/SoftwareInstructions/DisplayFunctions.asm"



;;;___BEGIN ENTERING 32 BIT PROTECTED MODE HERE___;;;

%include "../BootloaderAssembly/BootModeInstructions/GlobalDescriptorTable.asm"

AfterGDTCodeDescriptor: equ GDTCodeDescriptor - GDTNullDescriptor
AfterGDTDataDescriptor: equ GDTDataDescriptor - GDTNullDescriptor
                                                ; The label gets the code or data section, but is named
                                                ; to make its function more understandable during the "long" jump
EnterProtectedMode32Bits:
	call EnableA20
	cli
	lgdt [GDTDescriptor]
	mov eax, cr0
	or eax, 1
	mov cr0, eax
	jmp AfterGDTCodeDescriptor:ProtectedMode32Bits

EnableA20:
	in al, 0x92
	or al, 2
	out 0x92, al
	ret

[bits 32]                                       ; From this point on, BIOS interrupts aren't operational

ProtectedMode32Bits:
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

	jmp EnterProtectedMode64Bits



;;;___CHANGE TO 64 BIT PROTECTED MODE HERE___;;;

%include "../BootloaderAssembly/BootModeInstructions/CentralProcessingUnitIdentifier.asm"
%include "../BootloaderAssembly/BootModeInstructions/SimplePaging.asm"

EnterProtectedMode64Bits:
	call DetectCPUID
	call DetectLongModeSupport
	call IdentityPagingSetup

UpdateGlobalDescriptorTable:
	mov [GDTCodeDescriptor + 6], byte 10101111b
	mov [GDTDataDescriptor + 6], byte 10101111b

	jmp AfterGDTCodeDescriptor:ProtectedMode64Bits

[bits 64]

ProtectedMode64Bits:
	mov edi, 0xB8000
	mov rax, 0x1F201F201F201F20                 ; 1F=foreground:white/background:blue, 20=space
	mov ecx, 500
	rep stosq

	jmp $

times 2048-($-$$) db 0