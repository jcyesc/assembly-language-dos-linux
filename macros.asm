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

%macro write 1	
	mov dx,%1
	mov ah,9h		; Select DOS service 9: Print String
	int 21h			; Call DOS
%endmacro	

[SECTION .data]              ; Section containing initialised data

msg1 db "Message not in the center", 13, 10, "$"  ; First Message
msg2 db "Message under the first message", 13, 10, "$" ; Second Message
salto db "", 13, 10, "$"

[SECTION .text]              ; Section containing code
START:	

	; CAPTURED DATA
	write msg1		; print the string
	
  	call exit		; the program has finished
;-------------------------------
; PROCEDURE SECTION
;-------------------------------

				; Return to the caller


exit:
	mov    ax, 04C00H        ; This DOS function exits the program
    int    21H               ; and returns control to DOS.
	ret



