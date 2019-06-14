;  Source name     : gotoXY.ASM
;  Executable name : gotoXY.COM
;  Code model:     : Real mode flat model
;  Version         : 1.0
;  Created date    : 17/Octubre/2008
;  Author          : Juan Carlos Yescas
;  Description     : This program moves the cursor to X and Y using the
;					 the BIOS services.

[BITS 16]                    ; Set 16 bit code generation
[ORG 0100H]                 ; Set code start address to 100h (COM file)

[SECTION .data]              ; Section containing initialised data

msg1 db "Message not in the center", 13, 10, "$"  ; First Message
msg2 db "Message under the first message", 13, 10, "$" ; Second Message
salto db "", 13, 10, "$"

[SECTION .text]              ; Section containing code
START:	

	; CAPTURED DATA
	mov dx, msg1    ; Mem data ref without [] loads the ADDRESS!
	call write		; print the string

	mov dx, 01010h		; Stablish the X and Y position values
	call gotoXY		; Position the cursor
	mov dx, msg2	; Load offset of msg2 string into dx
	call write
	
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

saltar:
	mov dx, salto	; Load offsert of newline string to DX
	call write		; Dsiplay the newline string through write
	ret
	
; The new position of the cursor must be loaded into the two hales of the DX register.
; The X component is loaded into DL, and the Y component is loaded into DH.
gotoXY:
	mov ah, 2h		; Select VIDEO service 2: Poition cursor
	mov bh, 0		; Stay with display page 0
	int 10h			; Call VIDEO
	ret				; return to the caller

exit:
	mov    ax, 04C00H        ; This DOS function exits the program
    int    21H               ; and returns control to DOS.
	ret



