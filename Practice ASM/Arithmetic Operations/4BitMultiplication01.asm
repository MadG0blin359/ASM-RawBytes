[org 0x0100]
jmp start

multiplicand: db 13		; 4-bit number 8-bit space
multiplier: db 5		; 4-bit multiplier
result: db 0			; 8-bit result

start:	mov bl, [multiplicand]
	mov cl, 4
	mov dl, [multiplier]

checkbit: shr dl, 1
	  jnc skip

add [result], bl

skip:	shl bl, 1
	dec cl
	jnz checkbit

mov ax, 0x4c00
int 0x21