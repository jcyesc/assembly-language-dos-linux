; Sourc name 		: showargs.asm
; Executable name	: showargs
; Version			: 1.0
; Author			: Juan 
; Description		: A program that shows how to print all the environment variables
;
;
; Build using these commands:
;	nasm -f elf environmentvar.asm
;	gcc environmentvar.o -o environmentvar
;
; To test, execute with some command-line arguments:
; ./environmentvar

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

	mov edi,[ebp+16]	 ; Load the address of the table of environment variables
	xor esi, esi		 ; Clear esi to 0

.showit
	cmp dword[edi+esi*4], 0 ; Compare if there is a NULL pointer
	jz end					; If there is a NULL pointer jump to end
	push dword [edi+esi*4]	; Push the environment variable in the stack
	push dword argmsg		; Push the msg in the stack
	call printf				; Call printf
	add esp, byte 8			; Clear up stack after print call
	inc esi					; Increment esi to go to the next argument
	jmp .showit				; Jump to show it
end:
	push dword endmsg		; Push the message of the end of the program
	call printf				; Call printf
	add esp, byte 4			; Clear up stack
	
	;;; Everything after this is boilerplate; use it for all ordinary apps!
	pop edi			; Restore saved registers
	pop esi
	pop ebx
	mov esp, ebp	; Destroy stack frame before returning
	pop ebp
	ret				; Return control to Linux

[SECTION .data]		; Section containing initialized data

argmsg	db "Environment variable %s",10,0
endmsg		db "This is the end of the program", 10, 0

[SECTION .bss]		; Section containing uninitialized data
