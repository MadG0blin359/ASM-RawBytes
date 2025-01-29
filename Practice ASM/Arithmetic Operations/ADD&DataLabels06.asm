[org 0x0100]

mov byte [num], 5	; store the constant in byte
mov byte [num+1], 10	; store the constant in byte
mov byte [num+2], 15	; store the constant in byte

mov al, [num]		; load first number in al
add [num+3], al		; add first number in last number
mov al, [num+1]		; load second number in al
add [num+3], al		; add second number in last number
mov al, [num+2]		; load third number in al
add [num+3], al		; add third number in last number

mov ax, 0x4c00		; terminate program
int 0x21

num: db 0, 0, 0, 0