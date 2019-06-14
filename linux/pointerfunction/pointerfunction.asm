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

	push dword welcome ; push the address of the message
	; POINTER TO FUNCTION1	
	mov ebx, function1 ; store the address of function1 into ebx
	call execute	   ; call execute

	; POINTER TO FUNCTION2
	mov ebx, function2 ; store the address of function2 into ebx
	call execute

	;;; Everything after this is boilerplate; use it for all ordinary apps!
	pop edi			; Restore saved registers
	pop esi
	pop ebx
	mov esp, ebp	; Destroy stack frame before returning
	pop ebp
	ret				; Return control to Linux

execute:
	call ebx		; call the function in ebx
	ret				; return

function1:
	push fun1msg	; push fun1msg into the stack
	call printf		; call printf
	add esp, byte 4 ; Clean up stack
	ret

function2:
	push fun2msg	; push fun2msg into the stack
	call printf		; call printf
	add esp, byte 4 ; Clean up stack
	ret

[SECTION .data]		; Section containing initialized data

welcome db "Welcome to the pointer to functions program",10,0
fun1msg db "Function 1",10,0
fun2msg db "Function 2",10,0

[SECTION .bss]		; Section containing uninitialized data
