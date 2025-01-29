[org 0x0100]

mov ax, [num]		; load first number in ax
add [num+6], ax		; add first number in last number
mov ax, [num+2]		; load second number in ax
add [num+6], ax		; add second number in last number
mov ax, [num+4]		; load third number in ax
add [num+6], ax		; add third number in last number

mov ax, 0x4c00
int 21h

num: dw 5, 10, 15, 0