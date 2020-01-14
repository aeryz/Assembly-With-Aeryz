
global _start

_start:
	push ebp
	mov ebp, esp
	sub esp, 0x8
	mov dword [ebp-0x4], 0x00434241
	mov eax, ebp
	push 0x4
	sub eax, 0x4
	push eax
	sub eax, 0x4
	push eax
	call my_memcpy
	add esp, 0xc
	mov edx, 3
	mov ecx, ebp
	sub ecx, 0x8
	mov ebx, 1
	mov eax, 4
	int 0x80
	mov eax, 1
	int 0x80


awa_memcpy:
	mov edi, [esp+0x4]
	mov esi, [esp+0x8]
	mov ecx, [esp+0xc]
	
	cmp edi, esi ; Check if edi = esi
	je .memcpy_ret
	rep movsb 
	.memcpy_ret:
	ret

