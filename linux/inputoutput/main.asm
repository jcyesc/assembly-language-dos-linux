;  Source name     : main.ASM
;  Executable name : main
;  Version         : 1.0
;  Created date    : 22-nov-2008
;  Author          : Juan Carlos Yescas
;  Description     : This is an example of how to linked two asm files, and
;					 how to read a file
;
;  Build using these commands:
;    nasm -f elf main.asm
;    nasm -f elf libraryfile.asm
;    gcc main.o libraryfile.o -o main
;
;  Note that this program requires several subroutines in an external
;  library named LIBRARYFILE.ASM
	 
		
[SECTION .text]			; Section containing code

;; These externals are all from the standard C library:	 
extern printf
extern scanf

;; These externals are from the associated library LIBRARYFILE.ASM:	 
extern readFile

global main			; Required so linker can find entry point
	
main:
    push ebp		; Set up stack frame for debugger
	mov ebp,esp
	push ebx		; Program must preserve ebp, ebx, esi, & edi
	push esi
	push edi
	;;; Everything before this is boilerplate; use it for all ordinary apps!	

	push dword msgtitle	; Push the address of the msgtitle
	call printf			; Call printf
	add esp,4			; Clean up the stack 1 arg x 4 bytes = 4
	
	push dword file		; Push the address of the name of the file
	push dword msgfile	; Push the address of the msg
	call printf			; Call printf
	add esp,8			; Clean up the stack 2 args x 4 bytes = 8
	
	push dword file		; Push the address of the name of the file
	call readFile		; Call readFile
	add esp,4			; Clean up the stack 1 arg x 4 bytes = 4

	;;; Everything after this is boilerplate; use it for all ordinary apps!
	pop edi			; Restore saved registers
	pop esi
	pop ebx
	mov esp,ebp		; Destroy stack frame before returning
	pop ebp
	ret			; Return control to to the C shutdown code

[SECTION .data]			; Section containing initialized data

msgtitle  db "This program reads a file using FOPEN:",10,0		
file	  db "text.txt",0
msgfile   db "Trying to open the file %s",10,0
	
[SECTION .bss]			; Section containing uninitialized data


