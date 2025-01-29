[org 0x0100]
jmp start

num1: db 8
num2: db 10

start:	inc byte [num1]
	mov al, [num1]
	cmp al, [num2]

mov ax,0x4c00
int 0x21