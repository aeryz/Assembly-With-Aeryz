
section .text
	global _start

section .data
	msg db "this is sAmple message", 0x0
	notfound db "not found", 0x0

section .text
_start:
	mov ebx, 0x41
	push ebx
	mov ebx, msg
	push ebx
	call awa_strchr
	add esp, 0x8

	cmp eax, 0
	jz .start_finish

	mov edi, eax

	push edi
	push eax
	call awa_strlen
	add esp, 0x4
	pop edi

	mov edx, eax
	mov eax, 4
	mov ebx, 1
	mov ecx, edi
	int 0x80
	jmp .start_finish

.start_notfound:
	mov edx, 9
	mov eax, 4
	mov ebx, 1
	mov ecx, notfound
	int 0x80

.start_finish:
	mov eax, 1
	mov ebx, 0
	int 0x80


; strchr(char* str, int c);
awa_strchr:	
	mov edi, dword [esp + 0x4] ; str
	push edi
	call awa_strlen
	add esp, 0x4
	mov ecx, eax
	mov edi, dword [esp + 0x4]
	xor eax, eax                 
	mov al, byte [esp + 0x8]  ; c
	repne scasb             
	mov eax, edi
	ret

awa_strlen:
	mov edi, dword [esp+0x4] ; load char *
	or ecx, 0xffffffff
	mov ebx, edi ; save the original state of edi
	xor al, al   ; set al to zero (as '\0')
	repne scasb  ; repeat until null byte is seen
	mov eax, edi 
	sub eax, ebx ; set the return value to edi - ebx
	ret

