[org 0x0100]
jmp start

num: dw 2, 5, -3, 6, 8, 10, -6, -1, -7, 0
swap: db 0

start: mov bx, 0
mov byte [swap], 0

loop1: mov ax, [num+bx]
cmp ax, [num+bx+2]
jle noswap

mov dx, [num+bx+2]
mov [num+bx+2], ax
mov [num+bx], dx
mov byte [swap], 1

noswap: add bx, 2
cmp bx, 18
jne loop1

cmp byte [swap], 1
je start

mov ax, 0x4c00
int 0x21