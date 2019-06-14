; Source name		: charsin.asm
; Executable name	: charsin
; Version		: 1.0
; Created date		: 17-nov-2008
; Author		: Juan Carlos
; Description		: A data input demo for Linux, using NASM 0.99			
;
; Build using these commands:
;	nasm -f elf charsin.asm  (elf - Executable and linking format)
;	gcc charsin.o -o charsin
;

[SECTION .text]		; Section containing code

extern stdin		; Standard file variable for input
extern fgets
extern printf
extern scanf

global main		; Required so linker can find entry point

main:
	push ebp	; Set up stack frame for debugger
	mov ebp, esp
	push ebx	; Program must preserve ebp, ebx, esi, & edi
	push esi
	push edi
	;;; Everything before this is boilerplate; use it for all ordinary apps!

	;; First, an example of safely limited string input using fgets. Unlike 
	;; gets, which does not allow limiting the number of chars entered, fgets
	;; lets you specify a maximun number. However, you must also specify a
	;; file (hence the 'f' in 'fgets') so we must push the stdin handle.

	push dword sprompt  ; Push address of the string input prompt string
	call printf			; Display if
	add esp, 4			; Clean up stack for 1 arg

	push dword [stdin]	; Push predefined file handle for standard input
	push dword 72		; Accept no more than 72 characters from keyboard.
	push dword instring	; Push address of buffer for entered characters
	call fgets			; Call fgets
	add esp, 12			; 3 args x 4 bytes = 12 for stack cleanup

	push dword instring ; Push address of entered string data buffer
	push dword sshow	; Push address of the string display prompt.
	call printf			; Call printf
	add esp, 8			; Clean up the stack

	;; Next, we'll use scanf to enter numeric data. This is easier, becuse
	;; unlike strings, integers can only be so big and hence are self limiting.
	
	push dword iprompt	; Push address of the integer input prompt
	call printf			; Display it
	add esp, 4			; Clean up the stack
	
	push dword intval	; Push the address of the integer buffer
	push dword iformat	; Push the address of the integer format string
	call scanf			; Call scanf to enter numeric data
	add esp, 8			; Clean up the stack

	push dword [intval]	; Push integer value to display
	push dword ishow	; Push base string
	call printf			; Call printf to convert & display the integer
	add esp, 8			; Clean up the stack

	;;; Everything after this is boilerplate; use it for all ordinary apps!
	pop edi				; Restore saved registers 
	pop esi
	pop ebx
	mov esp, ebp		; Destroy stack frame before returning
	pop ebp
	ret					; Return control to Linuxs

[SECTION .data]		; Section containing initialized data

sprompt db "Enter string data, followed by Enter: ", 0
iprompt db "Enter an integer value, followed by Enter:    ",0
iformat db "%d",0
sshow   db "The string you entered was: %s", 10, 0
ishow   db "The integer value you entered was: %5d",10,0

[SECTION .bss]		; Section containing uninitialized data

intval   resd 1		; Reserve one uninitialized double word
instring resb 128   ; Reserve 128 bytes for string entry buffer


