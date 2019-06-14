; Source name 			: EAT.ASM
; Exectable name 		: EAT.COM
; Code model			: Real mode flat model
; Version				: 1.0
; Created date			: 16-Oct-2008
; Author				: Jeff Dunteman
; Description			: A simple example of a DOS .COM file programmed using NASM

[BITS 16]				;  Set 16 bit code generation
[ORG 0100H]			;  Set code start address to 100h (COM file)

[SECTION .text]			; Section containing code

START:

	mov dx, eatmsg		; Mem data ref without [] loads the ADDRESS!
	mov ah, 9			; Function 9 displays text to standard output.
	int 	21H			; INT 2H makes the call into DOS.

	mov	ax, 04C00H	; This DOS function exits the program
	int	21H			; and returns control to DOS

[SECTION .date]		; Section containing initialized data

eatmsg	db	"Eat at Joe's!", 13, 10, "$"  ; Here's our message

