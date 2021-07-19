; Set a size and offset

GDTNullDescriptor:
	dd 0
	dd 0

GDTCodeDescriptor:
	dw 0xFFFF                                   ; Set the limit to full section of memory
	dw 0x0000                                   ; Base; set the start of the section
	db 0x00                                     ; Base; within limit
	db 10011010b                                ; Access byte (See notes in ReadDiskFunctions.asm)
	db 11001111b                                ; Nerdy way to be efficient.
	db 0x00                                     ; Base; entirety of the section

GDTDataDescriptor:
	dw 0xFFFF                                   ; Set the limit to full section of memory
	dw 0x0000                                   ; Base; set the start of the section
	db 0x00                                     ; Base; within limit
	db 10010010b                                ; Access byte (See notes in ReadDiskFunctions.asm)
	db 11001111b                                ; Nerdy way to be efficient.
	db 0x00                                     ; Base; entirety of the section

GDTEnd:

GDTDescriptor:                                  ; This section calculates where the code is located
	GDTSize:
		dw GDTEnd - GDTNullDescriptor - 1
		dd GDTNullDescriptor