[org 0x0100]
jmp start

dest:	dd 40000
src:	dd 80000

start:	mov ax, [src]
	sub word [dest], ax
	
	mov ax, [src+2]
	sub word [dest+2], ax

mov ax, 0x4c00
int 0x21