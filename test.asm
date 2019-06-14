;  Source name     : entradaDatos.ASM
;  Executable name : entradaDatos.COM
;  Code model:     : Real mode flat model
;  Version         : 1.0
;  Created date    : 17/Octubre/2008
;  Author          : Juan Carlos Yescas
;  Description     : This program capture two numbers, show the numbers
; 					 we capture and the makes the sum. The sum must not be greater than 9.
;
;

[BITS 16]                    ; Set 16 bit code generation
[ORG 0100H]                 ; Set code start address to 100h (COM file)



[SECTION .data]              ; Section containing initialised data

msg1 db "Introduce el primer numero", 13, 10, "$"  ; First Message
msg2 db "Introduce el segundo numero", 13, 10, "$" ; Second Message
msg3 db "Primer numero = ", "$"
msg4 db "Segundo numero = ", "$"
salto db "", 13, 10, "$"


[SECTION .text]              ; Section containing code
START:	

	; CAPTURED DATA
	mov dx, msg1    ; Mem data ref without [] loads the ADDRESS!
	call writeln	; print the string

	; FIRST NUMBER BL
	mov ah, 1h 		; keyboard input subprogram
	int 21h 		; read character into al
	mov bl, al 		; copy first number to BL
	
	mov dx, msg2	; show the second message
	call writeln	; print the string
    
    ; SECOND NUMBER BH
	mov ah, 1h 		; capture the second operand
	int 21h			; read character into al
	mov bh, al 		; copy character to BH

    mov    ax, 04C00H        ; This DOS function exits the program
    int    21H               ; and returns control to DOS.


;-------------------------------
; PROCEDURE SECTION
;-------------------------------

write:
	mov ah, 9h		; Select DOS service 9: Print String
	int 21h			; Call DOS
	ret				; Return to the caller


writeln:
	call write		; Display the string proper through write
	mov dx, salto	; Load offsert of newline string to DX
	call write		; Dsiplay the newline string through write
	ret				; return to the caller
	
	
putChar:
	mov ah, 2h		; Select DOS service 2 : Print a character
	int 21h			; Call DOS
	ret 			; Return to the caller






