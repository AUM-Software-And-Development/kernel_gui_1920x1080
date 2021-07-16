[org 0x1000]

	mov di, postBootSetupString
	call DisplayString
	call DisplayNewLine

postBootSetupString:
	db "The boot from a disk was a success.", 0

%include "../BootloaderAssembly/SoftwareInstructions/DisplayFunctions.asm"

times 2048-($-$$) db 0