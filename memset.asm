
section .text
	global _start

section .data
	test_str db "TEST_STR", 0xa

section .text

_start:
	mov edx, test_str
	push ebp
	mov ebp, esp
	sub esp, 0x8
	push 8
	push 0x41 ; 'A'
	lea ebx, [esp]
	push ebx
	call memset
	
	mov eax, 4
	mov ecx, ebx
	mov ebx, 1
	mov edx, 8
	int 0x80

	mov eax, 1
	int 0x80

; memset(void* dest, int x, size_t n);
awa_memset:
	mov edi, [esp + 0x4]     ; dest
	mov al, byte [esp + 0x8] ; x
	mov ecx, [esp + 0xc]     ; n
	rep stosb
	ret

