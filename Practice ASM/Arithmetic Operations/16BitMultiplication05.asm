[org 0x0100]

jmp start

multiplicand: db 50
multiplier: db 40
result: dw 0

start: mov ax, 0
mov bl, [multiplicand]
mov cl, [multiplier] 		; Update counter with Multiplier

loop1: cmp cl, 0 		; Compare counter with 0
je exit
add ax, bx 			; Add Multiplicand into al register
dec cl
jmp loop1

exit: mov [result], ax 		; Store final value in result variable
mov ax, 0x4c00 			; Terminate Program
int 0x21