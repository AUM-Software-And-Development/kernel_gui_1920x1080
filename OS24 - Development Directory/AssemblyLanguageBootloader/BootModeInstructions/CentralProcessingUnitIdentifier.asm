DetectCPUID:
	pushfd
	pop eax
	mov ecx, eax
	xor eax, 1 << 21                            ; Flip first bit
	push eax
	popfd
	pushfd
	pop eax
	push ecx
	popfd
	xor eax, ecx                                ; Culling bits to check if bit remains flipped (compatible)
	jz NoCPUID
	ret

DetectLongModeSupport:
	mov eax, 0x80000001
	cpuid                                       ; Since CPUID exists, can use a hardcoded process
	test edx, 1 << 29
	jz NoLongModeSupport
	ret

NoLongModeSupport:
	hlt                                         ; That's all for now. Need to add a method to stay in 32 bits.

NoCPUID:
	hlt                                         ; That's all for now. Need to add a method to stay in 32 bits.

; I am not very good at explaining how this part works yet, but I plan to include more detailed notes in a later
; version.