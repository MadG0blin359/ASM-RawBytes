[org 0x0100]

mov ax, [num]		; load the first number in ax
add [result], ax	; add ax in result
mov ax, [num+2]		; load second number in ax
add [result], ax	; add ax in result
mov ax, [num+4]		; load third number in ax
add [result], ax	; add ax in result
mov ax, [num+6]		; load fourth number in ax
add [result], ax	; add ax in result
mov ax, [num+8] 	; load fifth number in ax
add [result], ax	; add ax in result

mov ax, 0x4c00		; terminate program
int 0x21

num: dw 5, 10, 15, 20, 25
result: dw 0