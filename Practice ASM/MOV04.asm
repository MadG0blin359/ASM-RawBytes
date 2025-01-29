[org 0x0100]
jmp start

start:	mov ax, 1A11h

mov ax, 0x4c00
int 0x21