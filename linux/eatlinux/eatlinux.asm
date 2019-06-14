;Source name		: characters.asm
; Executable name	: characters
; Version			: 1.0
; Author			: Juan Carlos
; Description		: A simple program in assembly for Linux, using NASM 0.98,
;				demonstrating the use of the puts C library routine to display text.
;
; Build using these commands:
;	nasm -f elf eatlinux.asm  (elf - Executable and linking format)
;	gcc eatlinux.o  -o eatlinux
;

[SECTION .text]		; Section containing code

extern puts
global main			; Required so linker can find entry point

main:
	push ebp		; Set up stack frame for debugger
	mov ebp, esp
	push ebx		; Program must preserve ebp, ebx, esi, & edi
	push esi
	push edi
	
	;;; Everything before this is boilerplate; use it for all ordinary apps!
	
	push dword eatmsg	; Push a 32-bit pointer to the message on the stack
	call puts			; Call the clib function for displaying strings
	add esp, 4			; Clean stack by adjusting esp back 4 bytes
	
	;;; Everything after this is boilerplate; use it for all ordinary apps!
	pop edi				; Restore saved registers
	pop esi
	pop ebx
	mov esp, ebp		; Destroy stack frame before returning
	pop ebp
	ret					; Return control to Linux
	
[SECTION .data]			; Section containing initialized data

eatmsg: db "Welcome to the Unix programming",0

[SECTION .bss]			; Section containing uninitialized data

