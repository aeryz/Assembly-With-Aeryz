
section .text
	global _start

section .data
	test_str db "TEST_STR", 0xa

section .text
; strlen(char * str);
_start:
	mov edx, test_str
	push edx
	call awa_strlen
	add esp, 4
	mov ecx, test_str
	mov edx, eax ; length of str
	mov eax, 4
	mov ebx, 1
	int 0x80

	mov ebx, 0
	mov eax, 1
	int 0x80

awa_strlen:
	mov edi, dword [esp+0x4] ; load char *
	or ecx, 0xffffffff
	mov ebx, edi ; save the original state of edi
	xor al, al   ; set al to zero (as '\0')
	repne scasb  ; repeat until null byte is seen
	mov eax, edi 
	sub eax, ebx ; set the return value to edi - ebx
	ret


