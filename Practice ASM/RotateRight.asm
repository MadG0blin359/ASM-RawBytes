[org 0x0100]
jmp start

src: db 0x054
dst: db 0x10

start:	mov al, [src]
	ror al, 1
	add [dst], al

mov ax, 0x4c00
int 0x21