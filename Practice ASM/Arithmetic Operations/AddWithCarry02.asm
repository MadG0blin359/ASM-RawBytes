[org 0x0100]
jmp start

num1:	dd 4000000000
num2: 	dd 800000000
result:	dd 0

start:	mov ax, [num1]
	add ax, [num2]
	mov [result], ax

	mov ax, [num1+2]
	adc ax, [num2+2]
	mov [result+2], ax

mov ax, 0x4c00
int 0x21