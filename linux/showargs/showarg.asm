; Sourc name 		: showargs.asm
; Executable name	: showargs
; Version			: 1.0
; Created date		: 19-nov-2008
; Author			: Juan 
; Description		: A  demo that shows how to access command line arguments
;					  stored on the stack by addressing them relative to ebp.
;
; Build using these commands:
;	nasm -f elf showargs.asm
;	gcc showargs.o -o showargs
;
; To test, execute with some command-line arguments:
; ./showargs foo bar bas bat

[SECTION .text]		; Section containing code

global main			; Required so linker can find entry point
extern printf		; Notify linker that we're calling printf

main:
	push ebp		;  Set up stack frame for debugger
	mov ebp, esp
	push ebx		; Program must preserve ebp, ebx, esi, & edi
	push esi
	push edi
	;;; Everything before this is boilerplate; use it for all ordinary apps!

	mov edi,[ebp+8]	 ; Load argument count into edi
	mov ebx,[ebp+12] ; Load pointer to argument table into ebx
	xor esi, esi	 ; Clear esi to 0
 .showit:
	push dword [ebx+esi*4]	; Push address of an arg on the stack
	push esi				; Push arg number on the stack
	push dword argmsg		; Push address of display string on the stack
	call printf				; Display the arg number and arg
	add esp, byte 12		; Clean up stact after printf call
	inc esi					; Bump arg number to next arg
	dec edi					; Decrement arg counter by 1
	jnz .showit				; If arg count is 0, we're done	

	;;; Everything after this is boilerplate; use it for all ordinary apps!
	pop edi			; Restore saved registers
	pop esi
	pop ebx
	mov esp, ebp	; Destroy stack frame before returning
	pop ebp
	ret				; Return control to Linux

[SECTION .data]		; Section containing initialized data

argmsg	db "Argument %d: %s",10,0

[SECTION .bss]		; Section containing uninitialized data
