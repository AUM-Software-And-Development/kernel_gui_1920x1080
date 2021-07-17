PAGE_TABLE_ADDRESS equ 0x2000                   ; Don't overwrite the Post Boot Section

IdentityPagingSetup:
	mov edi, PAGE_TABLE_ADDRESS
	mov cr3, edi                                ; Places address into memory management unit to start there
	mov dword [edi], 0x3003
	add edi, 0x1000
	mov dword [edi], 0x4003
	add edi, 0x1000
	mov dword [edi], 0x5003
	add edi, 0x1000
	mov ebx, 0x00000003
	mov ecx, 512
.setentry:
	mov dword [edi], ebx
	add ebx, 0x1000
	add edi, 8
	loop .setentry
		mov eax, cr4
		or eax, 1 << 5
		mov cr4, eax
		mov ecx, 0xc0000080
		rdmsr
		or eax, 1 << 8
		wrmsr
		mov eax, cr0
		or eax, 1 << 31
		mov cr0, eax
	ret

; I am not very good at explaining how this part works yet, but I plan to include more detailed notes in a later
; version.