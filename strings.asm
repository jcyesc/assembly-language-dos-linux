;  Source name     : strings.ASM
;  Executable name : strings.COM
;  Code model:     : Real mode flat model
;  Version         : 1.0
;  Created date    : 6/Noviembre/2008
;  Author          : Juan Carlos Yescas
;  Description     : This program shows how to work with string, and prints the vocabulary

[BITS 16]                    ; Set 16 bit code generation
[ORG 0100H]                 ; Set code start address to 100h (COM file)

[SECTION .data]              ; Section containing initialised data

title db "VOCABULARY", 13, 10, "$"
vocal db ""
salto db "", 13, 10, "$" ; Defines a line feed and carriage return
address dd 0h

[SECTION .text]              ; Section containing code
START:	

	; CAPTURED DATA
	mov cx, 0CH		 	; Leght of string 10H
	mov dx, title    	; Mem data ref without [] loads the ADDRESS!
	call print		 	; print the string
	
	mov ax, 'a'			; initial character in the vocabulary
	mov cx, 1AH			; Number of characters in the vocabulary
	
	mov bx, vocal
	mov [address], bx
	mov DI, [address]
		
vocabulary:	mov [DS:DI], ax ; Copy AX to the address DS:DI
	 		inc	DI			; Increment DI to the next memory position
	 		inc ax			; Increment AX to get the next character
		 	dec CX			; Decrement CX by one position
	 		jnz vocabulary		; and loop again until CX is 0
	
	mov cx, 1AH		 	; Leght of the vocabulary 26 = 1AH
	mov dx, vocal    	; Load the address where the vocabulary start
	call print		 	; print the string
	
	call exit			; End of the program	
	
;-------------------------------
; PROCEDURE SECTION
;-------------------------------

; Print the string that offset is in DX.
write:
	mov ah, 9h		; Select DOS service 9: Print String
	int 21h			; Call DOS
	ret				; Return to the caller

; Print the string that offset is in DX with a line feed.
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
	
; print		-- Print a string with certain lenght
;
;	Caller must pass:
;	CX : Length of the string to be printed
;	DX : Offset address of string passed in DX
print:
	mov BX,1		; Select DOS file handle 1: Standard output
	mov AH,40H		; Select DOS service 40: Print String
	int 21H			; call dos	
	ret
	
exit:
	mov    ax, 04C00H        ; This DOS function exits the program
    int    21H               ; and returns control to DOS.
	ret
	
