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
	mov ah,9        ; Function 9 displays text to standard output.
    int 21h         ; INT 21H makes the call into DOS.

	; FIRST NUMBER BL
	mov ah, 1h 		; keyboard input subprogram
	int 21h 		; read character into al
	mov bl, al 		; copy first number to BL

	;SALTO DE LINEA
	mov dx, salto    ; Mem data ref without [] loads the ADDRESS!
	mov ah,9        ; Function 9 displays text to standard output.
    int 21h         ; INT 21H makes the call into DOS.

	mov dx, msg2	; show the second message
	mov ah, 9		; display the second message
	int 21h			; makes teh call into Dos
    
    ; SECOND NUMBER BH
	mov ah, 1h 		; capture the second operand
	int 21h			; read character into al
	mov bh, al 		; copy character to BH

	;SALTO DE LINEA
	mov dx, salto    ; Mem data ref without [] loads the ADDRESS!
	mov ah,9        ; Function 9 displays text to standard output.
    int 21h         ; INT 21H makes the call into DOS.

	; SHOW CAPTURED DATA
	; FIRST NUMBER
	mov dx, msg3	; show the message of captured number
	mov ah, 9		; Function 9 displays text to standard output.
	int 21h			; INT 21H makes the calls into DOS
	
	mov dl, bl		; move first number to DL.
	mov ah, 2h 		; character output subprogram
	int 21h 		; display character in dl

	;SALTO DE LINEA
	mov dx, salto    ; Mem data ref without [] loads the ADDRESS!
	mov ah,9        ; Function 9 displays text to standard output.
    int 21h         ; INT 21H makes the call into DOS.

	; SECOND NUMBER
	mov dx, msg4	; show the message of captured number
	mov ah, 9		; Function 9 displays text to standard output.
	int 21h			; INT 21H makes the calls into DOS

	mov dl, bh		; move second number to DL.
	mov ah, 2h 		; character output subprogram
	int 21h 		; display character in dl
	
	;SALTO DE LINEA
	mov dx, salto    ; Mem data ref without [] loads the ADDRESS!
	mov ah,9        ; Function 9 displays text to standard output.
    int 21h         ; INT 21H makes the call into DOS.
    
	; ADD BL and BH
	add bl, bh 		; add number 1 to number 2
	
	sub bl, 48;
	
	; DISPLAY THE RESULT
	mov dl, bl		; move second number to DL.
	mov ah, 2h 		; character output subprogram
	int 21h 		; display character in dl

    mov    ax, 04C00H        ; This DOS function exits the program
    int    21H               ; and returns control to DOS.


