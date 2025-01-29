[org 0x0100]

mov bx, num		; point bx to first number
mov ax, [bx]		; load first number in ax
add bx, 2		; advance bx to second number
add ax, [bx]		; add second number to ax
add bx, 2		; advance bx to third number
add ax, bx		; add third number to ax
add bx, 2		; advance bx to last number
mov [bx], ax		; store sum at last number

mov ax, 0x4c00		; terminate program
int 0x21

num: dw 5, 10, 15, 0