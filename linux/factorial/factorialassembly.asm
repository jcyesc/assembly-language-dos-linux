;  Source name     : factorialassembly.ASM
;  Executable name : factorialassembly
;  Version         : 1.0
;  Created date    : 6-dic-2008
;  Author          : Juan Carlos Yescas
;  Description     : This program calculate the factorial of one number.
;					 The calculus is made using a recursive function and an iterative function.
;
;  Build using these commands:
;    nasm -f elf factorialassembly.asm
;    gcc factorialassembly.o -o factorialassembly
;
		
[SECTION .text]			; Section containing code

;; These externals are all from the standard C library:	 
extern printf
extern scanf

global main			; Required so linker can find entry point
	
main:
    push ebp		; Set up stack frame for debugger
	mov ebp,esp
	push ebx		; Program must preserve ebp, ebx, esi, & edi
	push esi
	push edi
	;;; Everything before this is boilerplate; use it for all ordinary apps!	

	push dword msgfactorial ; Push the address of msgfactorial in the stack
	call printf				; call printf
	add esp, 4				; clean up the stack 1 arg x 4 bytes = 4

	mov dword[number],5 	; Copy the number 5 to the variable number

	push dword[number]		; Push number in the stack
	call factorialIterativo	; Call factorialIterativo
	push dword eax			; Push EAX in the stack. EAX has the result return by factorialIterativo
	push dword[number]		; Push number in the stack
	push dword result		; Push the address of result in the stack
	call printf				; Call printf
	add esp, 16				; Clean up the stack 4 args * 4 bytes = 16

	mov dword[number], 6	; Copy the number 5 to the variable number
	push dword[number]		; Push number in the stack
	call factorialRecursivo	; Call factorialRecursivo
	push eax				; Push EAX in the stack
	push dword [number]		; Push the number value in the stack
	push dword result		; Push the address of the result in the stack
	call printf				; Call printf
	add esp, 16				; Clean up the stack 4 args * 4 bytes = 16
	

	call repetirFactorial	; call repetirFactorial to test the speed of the machine

	;;; Everything after this is boilerplate; use it for all ordinary apps!
	pop edi			; Restore saved registers
	pop esi
	pop ebx
	mov esp,ebp		; Destroy stack frame before returning
	pop ebp
	ret			; Return control to to the C shutdown code

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; REPETIR FACTORIAL
;;;;;;;;;;;;;;;;;;;;
; This function calls the factorial Recursivo 100000 times
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
repetirFactorial:

	mov dword[counter], 100000
.for
	dec dword[counter]		; Decrement the counter
	push dword[counter]		; Push the value of the counter in the stack
	push dword msgcounter	; Push the address of the msgcounter in the stack	
	call printf				; Call printf
	add esp,8				; Clean up the stack 2 args * 4 bytes = 8 

	mov eax,10				; Move the value of 10 to EAX
	push eax				; Push the value of EAX in the stack
	call factorialRecursivo	; Call factorialRecursivo with 7 as parameter
	add esp, 4				; Clean up the stack 1 arg * 4 bytes = 4
	cmp dword[counter], 0	; Compare the counter with ZERO
	jnz .for				; If the result was not ZERO, jump
	ret						; Return to the caller

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; RECURSIVE FACTORIAL FUNCTION
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This function calculates the factorial of a number
;  
; 	int factorial(int number)  
; 
;	NUMBER is pushed in the STACK
;   The result is return in EAX
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
factorialRecursivo:
	mov ebx, dword [esp+4]		; Get the number from the stack, and store it in EBX
	cmp ebx, 1					; Compare to check if it is 1 or less
	jle .return_1				; If it is 1 or less jump to .return_1

	mov ecx, ebx				; Copy the value of EBX in ECX
	dec ecx						; Decrement ECX
	push ebx					; Push the value of EBX (number) in the stack
	push ecx					; Push the value of ECX (number -1) in the stack
	call factorialRecursivo		; Call factorialRecursivo
	add esp, 4					; Clean up the stack 1 arg x 4 bytes = 4
	pop ebx						; Pop the value of EBX (number)
	imul eax, ebx				; Multiply EAX and EBX [ factorialRescursivo(number -1) * number ]
	ret							; Return to the caller

.return_1:						
	mov eax, 1					; Move 1 to EAX to return it
	ret							; Return to the caller

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ITERATIVE FACTORIAL FUNCTION
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This function calculates the factorial of a number
;  
; 	int factorial(int number)  
; 
;	NUMBER is pushed in the STACK
;   The result is return in EAX
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
factorialIterativo:
	mov eax,[esp+4]	; Get the number from the stack and store it in EAX
    cmp eax, 1		; Compare if EAX is equal to 1
	jle .return_1	; If it is equal or less jump to .return_1
	mov ebx, eax	; Copy EAX to EBX

.for:
	dec ebx			; Decrement EBX
	imul eax, ebx	; Multiply EAX and EBX (number = number * number -1)
	cmp ebx, 1		; Compare if EBX is equal to 1
	jz .return		; If EBX is equal to ZERO jump to .return
	jmp .for		; Jump to .for if EBX is not equal to ZERO.
	
.return:
	ret				; Return to the caller. In EAX is store the result

.return_1:						
	mov eax, 1		; Move 1 to EAX to return it
	ret				; Return to the caller

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[SECTION .data]			; Section containing initialized data
		
msgfactorial db "Iterative and Recursive Factorial Functions",10,0
result		 db "Factorial(%d) The result is %d",10,0
msgcounter	 db "Counter = %d",10,0

[SECTION .bss]		; Section containing uninitialized data

number  resd 1		; Reserve an integer (4 bytes)
counter resd 1		; Reserve an integer (4 bytes)


