; Source name 		: library.asm
; Version			: 1.0
; Author			: Juan Carlos 
; Description		: A library to print the multiply-tables
;
;
; Build using these commands:
;	nasm -f elf library.asm
;

[SECTION .text]		; Section containing code

;-------------------------------------------------------------
; EXTERNAL FUNCTIONS
;------------------------------------------------------------
extern printf		; Notify linker that we're calling printf

;-------------------------------------------------------------
; GLOBAL FUNCTIONS
;-------------------------------------------------------------
global printtable	; It's in charge of printing the tables
global myfunction	; This is function printf the value of EAX and EBX
global myfunctionparameters ; This function receives 2 parameters that are gotten throught the stack

;-------------------------------------------------------------
; myfunction
;
; This function prints the value of EAX and EBX
;
;-------------------------------------------------------------
myfunction:
	push ebx		; Push the value o ebx
	push eax		; Push the value o eax
	push dword registermsg	; Push the address of the message
	call printf		; Call printf
	add esp,12		; Clean up the stack 3 args x 4 bytes = 12
	ret		; Return to the caller

;--------------------------------------------------------------
; myfunctionparameters
;
; This function receives 2 parameters that are gotten throught the stack
;
;--------------------------------------------------------------
myfunctionparameters
	mov eax, dword [esp+4]	; Get the first parameter from the stack
	mov ebx, dword [esp+8]	; Get the second parameter from the stack
	push ebx				; Push the value of EBX
	push eax				; Push the value of EAX
	push dword parametersmsg	; Print the value of the parameters
	call printf				; Call print
	add esp,12				; Clean up the stack 3 args x 4 bytes = 12
	ret						; Return to the caller

;-------------------------------------------------------------
; printTable
; 
; This function is in charge to print the multiply tables.
; 
; This function gets the value that wants to be multiplied from the EAX.
;
;	3 x 0 = 0
;	3 x 1 = 3
;	3 x 2 = 6
;	3 x 3 = 9
;	....
;	3 x 10 = 30
; 
; Receive the value from EAX
;-------------------------------------------------------------
printtable:
	push ebp		; Push the EBP in the stack, because we need to save its value without changes
	xor esi, esi	; Establish ESI to ZERO
	mov ebp, eax	; Save the value of EAX in EBP to store the number we're going to multiply
.for:
	mov eax, ebp	; Store in EAX the value of EBP, that is the number we're multiplying
	imul eax, esi	; Multiply the number x ESI
	call print		; print the result of the operation
	inc esi			; increment the value of the ESI (counter)
	cmp esi, 10		; Compare if the value of ESI versus 10
	JNG .for		; If the value of ESI is not greater than 10, jump to for
	pop ebp			; Set the original value of EBP
	ret				; Return to the caller

print:
	push dword eax		; push EAX in the stack
	push dword esi		; push ESI in the stack
	push dword ebp		; push EBP in the stack
	push dword tablemsg	; push the address of the string "tablemsg"
	call printf			; call printf
	add esp, 16			; clear up the stack 4 args X 4 bytes = 16
	ret					; Return to the caller


[SECTION .data]		; Section containing initialized data

tablemsg db "%d X %d = %d",10,0
registermsg db "The value of the register is the following EAX = %d and EBX = %d",10,0 
parametersmsg db "The parameters were %d and %d",10,0

[SECTION .bss]		; Section containing uninitialized data
