[org 0x0100]
jmp start

multiplicand: dw 13			; 4-bit multiplicand 16-bit space
multiplier: db 80			; 8-bit multiplier
result: dw 0

start:	mov bx, [multiplicand]
	mov cl, 8
	mov dl, [multiplier]

checkbit: shr dl, 1
	  jnc skip

add [result], bx

skip:	shl bx, 1
	dec cl
	jnz checkbit

mov ax, 0x4c00
int 0x21