;  Source name     : sumafuncion.ASM
;  Executable name : sumafuncion.COM
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
msg5 db "Resultado = ", "$"
salto db "", 13, 10, "$"

[SECTION .text]              ; Section containing code
START:	

	; CAPTURED DATA
	mov dx, msg1    ; Mem data ref without [] loads the ADDRESS!
	call write	; print the string

	; FIRST NUMBER BL
	call getChar	; captured a character and store in al
	mov bl, al 		; copy first number to BL
	
	call saltar		; make a line feed	

	mov dx, msg2	; show the second message
	call write	; print the string
    
    ; SECOND NUMBER BH
	call getChar	; captured a character and store in al
	mov bh, al 		; copy character to BH

	call saltar		; make a line feed
	
	; SHOW CAPTURED DATA
	; FIRST NUMBER
	mov dx, msg3	; show the message of captured number
	call write	; print the string
	
	mov dl, bl		; move first number to DL.
	call putChar	; print a character in dl
	
	call saltar		; make a line feed	
	
	; SECOND NUMBER
	mov dx, msg4	; show the message of captured number
	call write	; print the string
	
	mov dl, bh		; move second number to DL.
	call putChar	; print a character in dl
	  
	call saltar		; make a line feed  
	  
	mov dx, msg5	; show the message of the result
	call write  	; print the string
	  
	; ADD BL and BH
	call sumar		; Add BL and BH and save the result in bl
	
	; DISPLAY THE RESULT
	mov dl, bl		; move second number to DL.
	call putChar	; print a character in dl

    call exit

;-------------------------------
; PROCEDURE SECTION
;-------------------------------

write:
	mov ah, 9h		; Select DOS service 9: Print String
	int 21h			; Call DOS
	ret				; Return to the caller

writeln:
	call write		; Display the string proper through write
	call saltar
	ret				; return to the caller
	
putChar:
	mov ah, 2h		; Select DOS service 2 : Print a character
	int 21h			; Call DOS
	ret 			; Return to the caller

; Captured a character and store it in AL
getChar:
	mov ah, 1h 		; capture the second operand
	int 21h			; read character into AL
	ret

saltar:
	mov dx, salto	; Load offsert of newline string to DX
	call write		; Dsiplay the newline string through write
	ret

; RESTRICTION : only give correct results when the result is less than 10
; Add BL and BH and save the result in bl
sumar:
	; ADD BL and BH
	add bl, bh 		; add number 1 to number 2
	sub bl, 48;		; substract 48 to give a number in ASCII.
	ret
	
exit:
	mov    ax, 04C00H        ; This DOS function exits the program
    int    21H               ; and returns control to DOS.
	ret



