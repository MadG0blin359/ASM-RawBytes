[org 0x0100]

mov al, [num1] 		; load first number in al
mov bl, [num1+1] 	; load second number in bl
add al, bl 		; accumulate sum in al
mov bl, [num1+2] 	; load third number in bl
add al, bl 		; accumulate sum in al
mov [num1+3], al 	; store sum at num1+3

mov ax, 0x4c00 		; terminate program
int 0x21

num1: db 5, 10, 15, 0