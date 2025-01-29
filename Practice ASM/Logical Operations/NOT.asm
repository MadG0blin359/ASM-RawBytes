[org 0x0100]
jmp start

invert:	dw 0

start:	mov ax, 1500		
	not ax			; Invert bits
	mov [invert], ax

mov ax, 0x4c00
int 0x21