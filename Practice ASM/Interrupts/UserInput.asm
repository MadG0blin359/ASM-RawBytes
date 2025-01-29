[org 0x0100]
jmp start

start:	mov ah, 10h			; service 10 – vga attributes 
		mov al, 03			; subservice 3 – toggle blinking 
		mov bl, 01			; enable blinking bit 
		int 0x10			; call BIOS video service

		mov ah, 0			; service 0 – get keystroke 
		int 0x16			; call BIOS keyboard service 

		mov ax, 0x4c00
		int 0x21