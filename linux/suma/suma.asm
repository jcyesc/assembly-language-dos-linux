; Source name		: time.asm
; Executable name	: time
; Version		: 1.0
; Created date		: 17-nov-2008
; Author		: Juan Carlos
; Description		: A simple program in assembly for Linux, using NASM 0.98,
;			  to capture strings and sum two numbers.			
;
; Build using these commands:
;	nasm -f elf time.asm  (elf - Executable and linking format)
;	gcc time.o -o time
;

[SECTION .text]		; Section containing code

extern getchar
extern printf
extern fgets
extern stdin
extern puts
extern scanf

global main			; Required so linker can find entry point

main:
	push ebp	; Set up stack frame for debugger
	mov ebp, esp
	push ebx	; Program must preserve ebp, ebx, esi, & edi
	push esi
	push edi
	;;; Everything before this is boilerplate; use if for all ordinary apps!	
	
	push msgname	; Push address of the instruction about the name
	call puts	; Call puts
	add esp, 4	; 1 arg x 4 bytes = 4 for stack cleanu
	
	push dword [stdin] ; Push predefined file handle for standard input
	push dword 40	   ; Accept no more than 40 characters from keyboard
	push dword name	   ; Push address of buffer for entered characteres
	call fgets	   ; Call fgets
	add esp, 12	   ; 3 args x 4 bytes = 12 for stack cleanup

	;; Capture the first number	
	push msgfirst	   ; Push address of buffer
	call puts	   ; call puts
	add esp, 4	   ; 1 arg x 4 bytes = 4 for stack cleanup

	push dword first   ; Push the address of the first integer buffer
	push dword iformat ; Push the address of the integer format string
	call scanf	   ; Call scanf to enter numeric data
	add esp, 8 	   ; Clean up the stack

	;; Capture the second number
	push msgsecond	   ; Push address of the second message 
	call puts	   ; Call puts
	add esp, 4	   ; Clean up the stack
	
	push dword second  ; Push the address of the second integer buffer
	push dword iformat ; Push the address of the integer format string
	call scanf	   ; Call scanf to enter the second number
	add esp, 8	   ; Clean up the stack

	; Add the numbers
	mov eax, dword [first]	; Move the first number to EAX
	mov ebx, dword [second] ; Move the second number to EBX
	add eax, ebx		; Sum EAX and EBX
	mov dword [result], eax	; Save the result of the sum in 'result'

	; Save the result in the stack
	push name	    ; Push the address of the user's name
	push dword [result] ; Push the address of the result of the sum
	push msgresult	    ; Push the address of the result string
	call printf	    ; call printf
	add esp, 12  	    ; 3 args x 4 bytes = 12 for stack clean up	

	;;; Everything after this is boilerplate; use it for all ordinary apps!
	pop edi		; Restore saved registers
	pop esi
	pop ebx
	mov esp, ebp	; Destroy stack frame before returning
	pop ebp
	ret		; Return control to Linux
	
[SECTION .data]		; Section containing initialized data

iformat   db "%d",0
msgname   db "Write your name",0
msgfirst  db "First number",0
msgsecond db "Second number",0
msgresult db "The result is %d, and your name is %s",0

[SECTION .bss]		; Section containing uninitialized data

first  resd 1		; Reserve an integer (4 bytes)
second resd 1		; Reserve an integer (4 bytes)
result resd 1		; Reserve an integer (4 bytes)
name  resb 40		; Reserve 40 bytes for name string


