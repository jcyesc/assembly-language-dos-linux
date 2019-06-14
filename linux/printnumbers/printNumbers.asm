;Source name		: characters.asm
; Executable name	: characters
; Version			: 1.0
; Created date		: 16-nov-2008
; Author			: Juan Carlos
; Description		: A simple program in assembly for Linux, using NASM 0.98,
;			  to print the number from 1 to 10				
;
; Build using these commands:
;	nasm -f elf printf.asm  (elf - Executable and linking format)
;	gcc printf.o  -o printf
;

[SECTION .text]		; Section containing code

extern printf
extern puts
global main			; Required so linker can find entry point

main:
	push ebp		; Set up stack frame for debugger
	mov ebp, esp
	push ebx		; Program must preserve ebp, ebx, esi, & edi
	push esi
	push edi
	
	;;; Everything before this is boilerplate; use it for all ordinary apps!
	push dword msgInicio	; Start message
	call puts		; Call to puts
	add esp, 4		; Stack cleanup: 1 arg x 4 bytes = 4
	mov eax, dword 0xA		; Move 10 to AX
	
imprimir:
	push dword eax		; Push a 32-bit number
	push dword result	; Push a 32-bit number
	call printf		; Call printf("Informacion %d", 45);
	add esp, 4		; Stack cleanup: 1 args x 4 bytes = 1
	pop dword eax	
	dec dword eax
	jnz imprimir

	push dword msgFin	; End message
	call puts		; Call to puts
	add esp, 4		; Stack cleanup: 1 arg x 4 bytes = 4
	
	;;; Everything after this is boilerplate; use it for all ordinary apps!
	pop edi				; Restore saved registers
	pop esi
	pop ebx
	mov esp, ebp		; Destroy stack frame before returning
	pop ebp
	ret					; Return control to Linux
	
[SECTION .data]			; Section containing initialized data

msgInicio: db "Inicia el programa", 0
msgFin: db "Fin de programa", 0
result: db " i = %d, "

[SECTION .bss]			; Section containing uninitialized data

