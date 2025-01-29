[org 0x0100]
jmp start

multiplicand: dd 1300 			; The first 16-bit number (1300) 32-bit space
multiplier: dw 500 			; The second number (500)
result: dd 0 				; Space to store the 32-bit result

start: mov cl, 16 			; Set the counter to 16 bits
mov dx, [multiplier] 			; Load multiplier into DX

checkbit: shr dx, 1 			; Shift DX right by 1 (divide multiplier by 2)
jnc skip 				; If carry flag is clear, skip addition
mov ax, [multiplicand] 			; Load multiplicand into AX
add [result], ax 			; Add to the lower part of result
mov ax, [multiplicand+2] 		; Load upper part of multiplicand
adc [result+2], ax 			; Add with carry to upper part of result

skip: shl word [multiplicand], 1 	; Shift least byte of multiplicand left by 1-bit (multiply by 2)
rcl word [multiplicand+2], 1 		; Shift through carry left by 1-bit
dec cl 					; Decrement counter
jnz checkbit 				; Repeat until all bits are processed

mov ax, 0x4c00 				; Exit program
int 0x21