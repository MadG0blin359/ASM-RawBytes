[org 0x0100]
jmp start

multiplicand: db 17
multiplier: db 6
result: dw 0

start:	mov al, 0
	mov bl, [multiplicand]
	mov dl, [multiplier]
	mov cl, 8

loop1:	shr dl, 1			; Shift 1-bit to the right
	jnc skip			; Jump if not carry

add al, bl				; Add multiplicand into al register

skip:	shl bl, 1			; Shift 1-bit to the left
	dec cl				; Decrement counter
	jnz loop1			; Jump if counter not zero

mov [result], al			; Store final value in result
mov ax, 0x4c00				; Terminate Program
int 0x21
