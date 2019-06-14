;  Source name     : sumafuncion.ASM
;  Executable name : sumafuncion.COM
;  Code model:     : Real mode flat model
;  Version         : 1.0
;  Created date    : 17/Octubre/2008
;  Author          : Juan Carlos Yescas
;  Description     : This program shows how to convert a number to a string using a lookup table.
;
; How to compile in windows -> nasm16 print.asm -f bin -o printNumber.com

[BITS 16]                    ; Set 16 bit code generation
[ORG 0100H]                 ; Set code start address to 100h (COM file)

[SECTION .data]              ; Section containing initialised data

msg DB "   es el resultado!", 13, 10, "$"
salto DB "", 13, 10, "$"
Digits DB "0123456789ABCDE"

[SECTION .text]              ; Section containing code
START:	

	; Print the number 17 in the screen
	mov AL,11H		; Number to be converted to string
	mov SI,msg		; Load the address of the string into SI
	call byte2Str	; Call to the function that converts a number to string
	mov dx, msg	; Mem data ref without [] loads the ADDRESS
	call write		; print the string

    call exit

;-------------------------------
; PROCEDURE SECTION
;-------------------------------

; The address of the string must be in DX.
write:
	mov ah, 9h		; Select DOS service 9: Print String
	int 21h			; Call DOS
	ret				; Return to the caller

writeln:
	call write		; Display the string proper through write
	call saltar
	ret				; return to the caller

saltar:
	mov dx, salto	; Load offsert of newline string to DX
	call write		; Dsiplay the newline string through write
	ret

; byte2Str:
;	Caller must pass:
;		AL: Byte to be converted
;		DS: Segment of destination string
;		SI: Offset of destination string
byte2Str:
	mov DI, AX			;Duplicate byte in DI
	and DI, 000FH		; Mask out high 12 bits of DI
	mov BX, Digits		; Load offset of Digits into DI
	mov AH,BYTE [BX+DI] ; Load digit from table into string
	mov [SI+1],AH		; and store diit into string
	xor AH,AH			; Zero out AH
	mov DI,AX			; And move byte into DI
	shr DI,4			; Shift high nybble of byte to low
	mov AH,BYTE [BX+DI] ; Load digit from table into AH
	mov [SI],AH			; and store digit into string
	ret					; We're done - go ome!
	
exit:
	mov    ax, 04C00H        ; This DOS function exits the program
    int    21H               ; and returns control to DOS.
	ret



