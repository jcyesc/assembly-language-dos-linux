;  Source name     : main.ASM
;  Executable name : main
;  Version         : 1.0
;  Created date    : 22-nov-2008
;  Author          : Juan Carlos Yescas
;  Description     : This is an example of how to linked two asm files, and
;					 how to use the libraries of other archives.
;
;  Build using these commands:
;    nasm -f elf main.asm
;    nasm -f elf library.asm
;    gcc main.o library.o -o main
;
;  Note that this program requires several subroutines in an external
;  library named LIBRARY.ASM
	 
		
[SECTION .text]			; Section containing code

;; These externals are all from the standard C library:	 
extern printf
extern scanf

;; These externals are from the associated library LIBRARY.ASM:	 
extern printtable

global main			; Required so linker can find entry point
	
main:
    push ebp		; Set up stack frame for debugger
	mov ebp,esp
	push ebx		; Program must preserve ebp, ebx, esi, & edi
	push esi
	push edi
	;;; Everything before this is boilerplate; use it for all ordinary apps!	

	push dword msglibrary	; Push the address of msglibrary in the stack
	call printf				; call printf
	add esp, 4				; clear up the stack

	mov eax, 4				; The number we want to multiply must be in EAX
	call printtable 		; call printtable

	push dword msgnumber	; Push the addres of msgnumber in the stack
	call printf				; call printf
	add esp, 4				; Clear up the stack 1 arg x 4 bytes = 4

	push dword number		; Address of the number we're going to capture
	push dword iformat		; Format of the data we're going to receive
	call scanf				; We call scanf
	add esp, 8				; Clear up the stack 2 args x 4 bytes = 8

	mov eax, [number]		; Move the content of the variable number to EAX
	call printtable			; Call printtable

	push dword msgsuccess	; Address of the ending string
	call printf				; call printf
	add esp, 4				; Clear up the stack 1 arg x 4 bytes = 4

	;;; Everything after this is boilerplate; use it for all ordinary apps!
	pop edi			; Restore saved registers
	pop esi
	pop ebx
	mov esp,ebp		; Destroy stack frame before returning
	pop ebp
	ret			; Return control to to the C shutdown code

[SECTION .data]			; Section containing initialized data
		
msglibrary  db "Using external libraries in the program",10,0
iformat	   	db "%i",0
msgnumber   db "Give the number you want to multiply",10,0
msgsuccess  db "The program has finished successfully",10,0
	
[SECTION .bss]			; Section containing uninitialized data

number  resd 1		; Reserve an integer (4 bytes)




















