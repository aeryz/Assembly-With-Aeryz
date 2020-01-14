
section .text
global _start


section .data
	str1 db "AAAA", 0x0
	str2 db "AAAB", 0x0
	less db "LESS", 0xa, 0x0
	greater db "GREATER", 0xa, 0x0
	equals db "EQUAL", 0xa, 0x0

section .text
_start:
	mov ebx, str1
	push ebx
	mov ebx, str2
	push ebx
	call awa_strcmp

	test eax, eax
	jg .start_greater
	jl .start_less
	
	mov ecx, equals
	mov edx, 6
	jmp .start_print	

.start_greater:
	mov ecx, greater
	mov edx, 8
	jmp .start_print

.start_less:
	mov ecx, less
	mov edx, 5

.start_print:
	mov eax, 4
	mov ebx, 1
	int 0x80

	mov eax, 1
	mov ebx, 0
	int 0x80

; strcmp(char* lhs, char* rhs)
awa_strcmp:	
	mov ebx, [esp + 0x4]
	cmp ebx, [esp + 0x8] ; test if pointers are same
	jnz .strcmp_equals

	.strcmp_cont:
	mov ebx, [esp + 0x4]
	push ebx
	call awa_strlen
	add esp, 0x4
	mov ebx, eax
	mov ecx, [esp + 0x8]
	push ecx
	call strlen 
	add esp, 0x4
	cmp eax, ebx
	jg .strcmp_greater
	jl .strcmp_less
	
	mov ecx, eax
	mov esi, [esp+0x4]
	mov edi, [esp+0x8]
	repe cmpsb
	jl .strcmp_less
	jg .strcmp_greater

	.strcmp_equals:
	mov eax, 0
	jmp .mstrcmp_finish
	.strcmp_greater:
	mov eax, 1
	jmp .strcmp_finish
	.strcmp_less:
	mov eax, -1
	jmp .strcmp_finish
	
	.strcmp_finish:
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

