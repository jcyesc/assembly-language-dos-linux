; Source name 		: libraryfile.asm
; Version			: 1.0
; Created date		: 22-nov-2008
; Author			: Juan Carlos 
; Description		: A library to read all the content of the file
;
;
; Build using these commands:
;	nasm -f elf libraryfile.asm
;

[SECTION .text]		; Section containing code

;-------------------------------------------------------------
; EXTERNAL FUNCTIONS
;------------------------------------------------------------
extern printf		; Notify linker that we're calling printf
extern fopen		; Open a file
extern fclose		; Close a file
extern fgets		; Read a line of text from a file

;-------------------------------------------------------------
; GLOBAL FUNCTIONS
;-------------------------------------------------------------
global readFile		; It's in charge of reading the file

;-------------------------------------------------------------
; readFile -
; ----------
; This function reads all the content of the file. The pointer to
; the file is pushed in the stack.
;
;-------------------------------------------------------------
readFile:
	mov ebx, [esp+4]	; Move the address of the file to ebx
	mov dword [address],ebx	; Move the address of the file to address
	push dword opencode	; Push pointer to open-for read code "r"
	push dword [address]; Pointer to the file
	call fopen			; Attemp to open the file for reading
	add esp, 8			; Clean up the stack 2 args X 4 bytes = 8	
	cmp eax,0			; fopen returns null if attempted open faile
	jne .siguiente		; Read the file from disk, else send a message
	call error
	ret 	; Return to the caller
	
  .siguiente:
	mov ebx,eax			; Save handle of opened file in ebx
  .rdln:
	push ebx			; Push file handle on the stack
	push dword BUFSIZE	; Limit line length of text read
	push dword line		; Push address of the line buffer
	call fgets			; Read a line of text from the file
	add esp, 12			; Clean up the stak
	cmp eax, 0			; A return null indicates error or EOF
	je .done			; If we get 0 in eax, close up & return
	push dword line		; Push address of the line on the stack
	call printf			; Call printf to display the line
	add esp,4			; Clean up the stack
  jmp .rdln 			; Jump to try to read other line again

  .done:
	push ebx		; Push the handle of the file to be close
	call fclose		; Closes the file whose handle is on the stack
	add esp,4		; Clean up the stack 1 arg x 4 bytes = 8
	ret				; Go home

error:
	push dword [address]	; Push the address of the file to be read
	push errorfile			; Push the address of the message
	call printf				; Call printf
	add esp, 8				; Crean up the stack 2 args x 4 bytes = 8


[SECTION .data]		; Section containing initialized data

opencode db "r",0
writecode db "w",0
errorfile db "El archivo %s no pudo ser abierto",10,0

[SECTION .bss]		; Section containing uninitialized data
BUFSIZE	EQU 16
line resb BUFSIZE
address resb 1

