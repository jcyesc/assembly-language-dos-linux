; Source name		: time.asm
; Executable name	: time
; Version		: 1.0
; Created date		: 17-nov-2008
; Author		: Juan Carlos
; Description		: A simple program in assembly for Linux, using NASM 0.98,
;			  to use the time functions.				
;
; Build using these commands:
;	nasm -f elf time.asm  (elf - Executable and linking format)
;	gcc time.o -o time
;

[SECTION .text]		; Section containing code

extern ctime
extern getchar
extern printf
extern localtime
extern time

global main			; Required so linker can find entry point

main:
	push ebp	; Set up stack frame for debugger
	mov ebp, esp
	push ebx	; Program must preserve ebp, ebx, esi, & edi
	push esi
	push edi
	;;; Everything before this is boilerplate; use if for all ordinary apps!	
	
	;;; Generate a time_t calendar time value with clib's time function
	push dword 0		; Push a 32-bit null pointer to stack, since 
				; we don't need a buffer. Time value is return in eax.
	call time		; Returns calendar time in eax
	add esp, byte 4 	; Clean up stack after call
	mov [oldtime], eax	; Save time value in memory variale
	
	;; Generat a string summary of local time with clib's ctime function
	push dword oldtime	; Push address of calendar time value
	call ctime		; Returns pointer to ASCII time string in eax
	add esp, byte 4		; Clean up stack after call
	
	push eax		; Push pointer to ASCII time string on stack
	push dword timemsg	; Push pinter to base message text string
	call printf		; Merge and display the two strings
	add esp, byte 8		; Clean up stack after call

	;;; Generate local time values into clib's static tm struct
	push dword oldtime	; Push address of calendar time value
	call localtime		; Returns pointer to static time structure in eax
	add esp, byte 4		; Clean up stack after call

	;;; Make a local copy of clib's static tm struct
	mov esi, eax		; Copy address of static tm from eax to esi
	mov edi, dword tmcopy	; Put the address of the local tm copy in edi
	mov ecx, 9		; A tm struct is 9 dwords in size under Linux
	cld			; Clear df to 0 so we move up-memory
	rep movsd		; Copy static tm struct to local copy in .bss

	;;; Display one of the fileds in the tm structure
	mov edx, dword[tmcopy + 20]	; Year value is 20 bytes offset into tm
	add edx, 1900	 ; Add 1900 years to the year	
	push edx	 ; Push value onto the stack
	push dword yrmsg ; Push address of the base string
	call printf	; Display string and year value with printf
	add esp, byte 8	; Clean up the stack

	;; Wait a few seconds for user to press Enter so we have a time difference

	call getchar

	;;; Calclating seconds passed since program began running with difftime
	push dword 0	; Push null ptr; we'll take value in eax
	call time	; Get current time value; return in eax
	add esp, byte 4 ; Clean up the stack
	mov [newtime], eax ; Save new time value

	sub eax, [oldtime]  ; Calculate time difference value
	mov [timediff], eax ; Save time difference value

	push dword [timediff] ; Push difference in seconds onto the stack
	push dword elapsed    ; Push addr. of elapsed time message string
	call printf	      ; Display elapsed time
	add esp, byte 8	      ; Clean up the stack 

	;;; Everything after this is boilerplate; use it for all ordinary apps!
	pop edi		; Restore saved registers
	pop esi
	pop ebx
	mov esp, ebp	; Destroy stack frame before returning
	pop ebp
	ret		; Return control to Linux
	
[SECTION .data]		; Section containing initialized data

timemsg db "Hey, what time is it? It's %s",10,0
yrmsg   db "The year is %d.",10,0
elapsed db "A total of %d seconds has elapsed since program began running.",10,0

[SECTION .bss]		; Section containing uninitialized data

oldtime  resd 1		; Reserve an integer (4 bytes)
newtime  resd 1		; Reserve an integer (4 bytes)
timediff resd 1		; Reserve an integer (4 bytes)
timestr	 resb 40	; Reserve 40 bytes for time string
tmcopy	 resd 9		; Reserve 9 integer fields for time struct tm





