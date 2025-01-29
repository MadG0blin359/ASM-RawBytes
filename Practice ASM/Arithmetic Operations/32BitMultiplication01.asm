[org 0x0100]
jmp start

multiplicand: dd 1300
multiplier: dw 500
result: dd 0

start: mov ax, 0
mov bx, [multiplicand]
mov dx, [multiplier]
mov cl, 16 			; Set counter to 16 as multiplier is 16-bit long

loop1: shr dx, 1
jnc skip

mov ax, [multiplicand] 		; Add first 16-bits into result
add [result], ax
mov ax, [multiplicand+2] 	; Add last 16-bits into result
adc [result+2], ax 		; Add through carry as the previous operation generates it

skip: shl word [multiplicand], 1 ; Shift multiplicand 1-bit to the left
rcl word [multiplicand+2], 1 	; Rotate through carry as previous shift dropped a bit
dec cl 				; Decrement counter
jnz loop1

mov ax, 0x4c00
int 0x21