;Source name		: characters.asm
; Executable name	: characters
; Version			: 1.0
; Created date		: 14-nov-2008
; Author			: Juan Carlos
; Description		: A simple program in assembly for Linux, using NASM 0.98,
;				demonstrating the use of the printf C library routine to display text.
;
; Build using these commands:
;	nasm -f elf printf.asm  (elf - Executable and linking format)
;	gcc printf.o  -o printf
;

[SECTION .text]		; Section containing code

extern printf
global main			; Required so linker can find entry point

main:
	push ebp		; Set up stack frame for debugger
	mov ebp, esp
	push ebx		; Program must preserve ebp, ebx, esi, & edi
	push esi
	push edi
	
	;;; Everything before this is boilerplate; use it for all ordinary apps!
	
	; printf("%d + %d = %d ... for large values of %d.", 2, 2, 5, 2);
	push dword 2 		; Push a 32-bit number
	push dword 5		; Push a 32-bit number
	push dword 2		; Push a 32-bit number
	push dword 2		; Push a 32-bit number
	push dword mathmsg	; Push a 32-bit pointer to the mathmsg on the stack
	call printf
	add esp, 20		; Stack cleanup: 5 args x 4 bytes = 20
	
	;;; Everything after this is boilerplate; use it for all ordinary apps!
	pop edi				; Restore saved registers
	pop esi
	pop ebx
	mov esp, ebp		; Destroy stack frame before returning
	pop ebp
	ret					; Return control to Linux
	
[SECTION .data]			; Section containing initialized data

mathmsg: db "%d + %d = %d ... for large values of %d.", 0

[SECTION .bss]			; Section containing uninitialized data

