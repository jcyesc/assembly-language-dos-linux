;  Source name     : sumafuncion.ASM
;  Executable name : sumafuncion.COM
;  Code model:     : Real mode flat model
;  Version         : 1.0
;  Created date    : 17/Octubre/2008
;  Author          : Juan Carlos Yescas
;  Description     : This program shows how to implement a for and an if.
;
; How to compile in windows -> nasm16 print.asm -f bin -o printNumber.com

[BITS 16]                    ; Set 16 bit code generation
[ORG 0100H]                 ; Set code start address to 100h (COM file)

[SECTION .data]              ; Section containing initialised data

counter DB "  ", 13, 10, "$"
tmp DB "  ", 13, 10, "$"
salto DB "", 13, 10, "$"
Digits DB "0123456789ABCDE"

[SECTION .text]              ; Section containing code
START:	
	mov byte [counter],17h 

	call workloop 	; we invoke the look
	call exit		; exit of the program
	
;-------------------------------
; PROCEDURE SECTION
;-------------------------------

; Method that print in order descend the number that is in counter
workloop:
	mov AL, byte [counter]	; copy the value of counter to AL
	mov byte [tmp],AL		; copy the value of AL in tmp
	mov SI, tmp				; load the address of tmp
	call byte2Str			; convert the number to char
	mov DX, tmp				; load tmp in dx for printing
	call writeln			; print the value of tmp

	dec BYTE [counter]		; dec the counter
	jz fin					; if counter is zero the method ends.
	jmp workloop			; repeat the cycle
fin:
	ret;

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



