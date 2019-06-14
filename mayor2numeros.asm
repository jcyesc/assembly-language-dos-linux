;  Source name     : sumafuncion.ASM
;  Executable name : sumafuncion.COM
;  Code model:     : Real mode flat model
;  Version         : 1.0
;  Created date    : 17/Octubre/2008
;  Author          : Juan Carlos Yescas
;  Description     : This program finds the greater of two numbers.
;					 The input is made by the keyboard.
;					 If both numbers are equals print a message indicating that
;
;

[BITS 16]                    ; Set 16 bit code generation
[ORG 0100H]                 ; Set code start address to 100h (COM file)

[SECTION .data]              ; Section containing initialised data

title db "'FIND THE GREATER'", 13, 10, "$"; Title
msg1 db "First number -> ", 13, 10, "$"  ; First Message
msg2 db "Second number -> ", 13, 10, "$" ; Second Message
result1 db "The greater is the first", 13, 10, "$" ; result1
result2 db "The greater is the second", 13, 10, "$" ; result2
equals db "Both numbers are equal", 13, 10, "$" ; Both numbers are equals
salto db "", 13, 10, "$" ; Defines a line feed and carriage return
number1 db 0 ; first number to be compared
number2 db 0 ; second number to be compared


[SECTION .text]              ; Section containing code
START:	

	; CAPTURED DATA
	mov cx, 12H		 	; Leght of title 12H
	mov dx, title    	; Mem data ref without [] loads the ADDRESS!
	call print		 	; print the string
	call saltar	 	 	; print a line feed
	
	; print a message to capture the first number and capture it
	mov dx, msg1	 	; print the message to capture the first number	
	call write		 	; print the message that offset is in dx
	call getChar	 	; scanf a character and the character is store in AL
	mov [number1], al	 ; store the captured number in the number1 variable
	
	call saltar			; make a line feed
	
	; print a message to capture the second number and capture it
	mov dx, msg2		; print the message to capture the second number
	call write 			; print the  message that offset is in dx
	call getChar		; scanf a character and the character is store in AL
	mov [number2], al 	; store the captured number in the number2 variable
	
	call saltar			; make a line feed
	
	mov al, [number2]	; copy the number2 to AL 
	mov ah, [number1]	; copy the number1 to AL

	call greater		; make a comparison to find the greater
	
	call exit			; End of the program	
	
;-------------------------------
; PROCEDURE SECTION
;-------------------------------

; Find the greater number 
;  Caller must pass the next
;		AX: must contain the numbers to be compared
greater:
	cmp ah, al			; if the AH is greater than AL, jump first number
	jz equal			; if the ZERO FLAG is stablish, jump equals
	jg firstNumber		; jump first number
	jmp secondNumber	; jump second number
equal:
	mov dx, equals		; move the offset of equals to DX
	call writeln		; print the string
	ret					; return to the caller
firstNumber:
	mov dx, result1		; move the offset of result1 to DX
	call writeln		; print the string
	ret					; return to the caller
secondNumber:
	mov dx, result2		; move the offset of result2 to DX
	call writeln		; print the string
	ret					; return to the caller

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
	
