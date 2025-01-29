[org 0x0100]

mov al, [num]		; load first number in al
mov [num+3], al		; store first number in last number
mov al, [num+1]		; add second number in al
add [num+3], al		; add second number in last number
mov al, [num+2]		; load third number in al
add [num+3], al		; add third number in last number

mov ax,0x4c00
int 21h

num: db 5, 10, 15, 0