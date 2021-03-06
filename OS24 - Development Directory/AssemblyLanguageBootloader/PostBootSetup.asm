; [org 0x1000] Linker sets this
[bits 16]

;;;___ARRIVE FROM THE BOOTLOADER HERE IN THE DEFAULT 16 BIT REAL MODE___;;;
	mov di, postBootSetupString
	call DisplayString
	call DisplayNewLine

	call EnableVESA                             ; From this point on, BIOS screen interrupts aren't operational
	
	jmp EnableProtectedMode32Bits

postBootSetupString:
	db "The boot from a disk was a success.", 0
%include "../../AssemblyLanguageBootloader/SoftwareInstructions/Int0x10DisplayFunctions.asm"
%include "../../AssemblyLanguageBootloader/HardwareInstructions/EnableVESA-EnableVBE.asm"



;;;___BEGIN ENTERING 32 BIT PROTECTED MODE HERE___;;;
%include "../../AssemblyLanguageBootloader/BootModeInstructions/GlobalDescriptorTable.asm"
AfterGDTCodeDescriptor: equ GDTCodeDescriptor - GDTNullDescriptor
AfterGDTDataDescriptor: equ GDTDataDescriptor - GDTNullDescriptor
                                                ; The label gets the code or data section, but is named
                                                ; to make its function more understandable during the "long" jump
EnableProtectedMode32Bits:
	call EnableA20
	cli
	lgdt [GDTDescriptor]
	mov eax, cr0
	or eax, 1
	mov cr0, eax
	jmp AfterGDTCodeDescriptor:ProtectedMode32Bits

EnableA20:
	in al, 92h
	or al, 2
	out 92h, al
	ret

[bits 32]                                       ; From this point on, BIOS interrupts aren't operational
%include "../../AssemblyLanguageBootloader/SoftwareInstructions/VESADisplayFunctions.asm"

ProtectedMode32Bits:
	mov ax, AfterGDTDataDescriptor
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

	mov esi, mode_info_block                    ; Places the mode info block address onto memory to work with
	mov edi, VESA_MODE_INFO_BLOCK_ADDRESS		; Give space to perform the 64 bit mode change later
	mov ecx, 64                                 ; Mode info block=256 byte / 4 = the number of double words
	rep movsd                                   ; Shifts entire block by 32 bits onto 5000h

	call VESAClearScreen
	call Exposed_Kernel                          ; The kernel is entirely in C. This jump leads to data defined by the linker
	cli
	hlt

VESA_MODE_INFO_BLOCK_ADDRESS: equ 0x6000
%include "../../HighLevelLanguageKernel/KernelHost.asm"

times 8192-($-$$) db 0






; While 64 bit mode is bootable; for now, I have no intention to extend these functions into it.
; Over time I will, but I feel that 32 bits with VESA is a better starting point.

;;;___CHANGE TO 64 BIT PROTECTED MODE HERE___;;;

; %include "../../AssemblyLanguageBootloader/BootModeInstructions/CentralProcessingUnitIdentifier.asm"
; %include "../../AssemblyLanguageBootloader/BootModeInstructions/SimplePaging.asm"

; EnterProtectedMode64Bits:
; 	call DetectCPUID
; 	call DetectLongModeSupport
; 	call IdentityPagingSetup

; UpdateGlobalDescriptorTable:
; 	mov [GDTCodeDescriptor + 6], byte 10101111b
; 	mov [GDTDataDescriptor + 6], byte 10101111b

; 	jmp AfterGDTCodeDescriptor:ProtectedMode64Bits

; [bits 64]

; ProtectedMode64Bits:
; 	mov edi, 0xB8000
; 	mov rax, 0x1F201F201F201F20                 ; 1F=foreground:white/background:blue, 20=space
; 	mov ecx, 500
; 	rep stosq

; 	cli
; 	hlt