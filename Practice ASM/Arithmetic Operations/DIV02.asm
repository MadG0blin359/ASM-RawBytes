[org 0x0100]
jmp start

num: db 113

result: db 0

start: mov ax, [num]
mov bl, 2
div bl 			; Divide ax by bl

mov [result], ah 	; If ah is zero then even, else odd

mov ax, 0x4c00
int 0x21